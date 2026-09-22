#!/usr/bin/env python3
"""Exercise deployment cleanup with fake CLIs; never contact a cluster."""

import json
import os
from pathlib import Path
import shutil
import signal
import subprocess
import tempfile
import time
import unittest


MOCK = r'''#!/usr/bin/env python3
import json
import os
from pathlib import Path
import signal
import sys
import time

name = Path(sys.argv[0]).name
args = sys.argv[1:]
if name == "sleep":
    sys.exit(0)
if name in ("kubectl", "flux"):
    assert args[args.index("--context") + 1] == "oidc@test-cluster", args
    assert args[args.index("--namespace") + 1] == "flux-system", args

if name == "kubectl":
    phase = next(verb for verb in ("get", "wait", "patch") if verb in args)
elif name == "flux":
    phase = args[0]
    if phase == "resume":
        phase = "cleanup" if "--wait=false" in args else "ready"
else:
    phase = "push"

with open(os.environ["MOCK_LOG"], "a") as log:
    log.write(json.dumps({"phase": phase, "args": args}) + "\n")

if phase == os.environ.get("MOCK_BLOCK"):
    for sig in (signal.SIGHUP, signal.SIGINT, signal.SIGTERM):
        signal.signal(sig, lambda number, frame: os._exit(128 + number))
    Path(os.environ["MOCK_MARKER"]).touch()
    while True:
        time.sleep(1)

failures = json.loads(os.environ.get("MOCK_FAILURES", "{}"))
if phase in failures:
    print(f"mock {phase} failure", file=sys.stderr)
    sys.exit(failures[phase])
if phase == "get":
    print(os.environ.get("MOCK_SUSPENDED", "false"))
'''


class ReconcileTest(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory(prefix="k8s-reconcile-test-")
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        (self.root / "hack").mkdir()
        (self.root / "k8s/test-cluster").mkdir(parents=True)
        (self.root / "k8s/test-cluster/list.cue").touch()
        for name in ("k8s-reconcile.sh", "k8s-deploy.sh"):
            shutil.copy2(Path(__file__).with_name(name), self.root / "hack" / name)
        mock = self.root / "mock"
        mock.write_text(MOCK)
        mock.chmod(0o755)
        (self.root / "bin").mkdir()
        for name in ("kubectl", "flux", "sleep"):
            (self.root / "bin" / name).symlink_to(mock)
        # Never execute the real publisher, even when testing the deploy wrapper.
        (self.root / "hack/k8s-push.sh").symlink_to(mock)
        self.log = self.root / "calls.jsonl"
        self.marker = self.root / "blocked"
        self.env = {
            **os.environ,
            "PATH": str(self.root / "bin") + os.pathsep + os.environ["PATH"],
            "MOCK_LOG": str(self.log),
            "MOCK_MARKER": str(self.marker),
        }

    def calls(self):
        return [json.loads(line) for line in self.log.read_text().splitlines()]

    def run_script(self, **env):
        return subprocess.run(
            [str(self.root / "hack/k8s-reconcile.sh"), "test-cluster"],
            env={**self.env, **env}, capture_output=True, text=True, timeout=5,
        )

    def assert_cleanup(self, count=1):
        calls = [call for call in self.calls() if call["phase"] == "cleanup"]
        self.assertEqual(len(calls), count, self.calls())
        for call in calls:
            self.assertIn("--timeout=10s", call["args"])

    def test_success(self):
        result = self.run_script()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(
            [call["phase"] for call in self.calls()],
            ["get", "suspend", "wait", "patch", "reconcile", "ready"],
        )
        self.assert_cleanup(0)

    def test_existing_suspension_is_preserved(self):
        result = self.run_script(MOCK_SUSPENDED="true")
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual([call["phase"] for call in self.calls()], ["get"])

    def test_failed_preflight_cannot_suspend(self):
        result = self.run_script(MOCK_FAILURES='{"get": 23}')
        self.assertEqual(result.returncode, 23, result.stderr)
        self.assertEqual([call["phase"] for call in self.calls()], ["get"])

    def test_failures_resume_once_and_preserve_exit_status(self):
        for phase in ("suspend", "wait", "patch", "reconcile", "ready"):
            with self.subTest(phase=phase):
                self.log.unlink(missing_ok=True)
                result = self.run_script(MOCK_FAILURES=json.dumps({phase: 42}))
                self.assertEqual(result.returncode, 42, result.stderr)
                self.assertEqual(self.calls()[-1]["phase"], "cleanup")
                self.assert_cleanup()

    def test_cleanup_failure_is_visible_and_preserves_original_error(self):
        result = self.run_script(MOCK_FAILURES='{"reconcile": 42, "cleanup": 43}')
        self.assertEqual(result.returncode, 42, result.stderr)
        self.assertIn("mock cleanup failure", result.stderr)
        self.assertIn("check its suspension state", result.stderr)
        self.assert_cleanup()

    def test_signals_exit_promptly_and_resume_once(self):
        for wrapper in ("k8s-reconcile.sh", "k8s-deploy.sh"):
            for phase in ("suspend", "reconcile", "ready"):
                for sig in (signal.SIGHUP, signal.SIGINT, signal.SIGTERM):
                    with self.subTest(wrapper=wrapper, phase=phase, signal=sig):
                        self.log.unlink(missing_ok=True)
                        self.marker.unlink(missing_ok=True)
                        process = subprocess.Popen(
                            [str(self.root / "hack" / wrapper), "test-cluster"],
                            env={**self.env, "MOCK_BLOCK": phase},
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            text=True, start_new_session=True,
                        )
                        try:
                            deadline = time.monotonic() + 5
                            while not self.marker.exists():
                                if process.poll() is not None or time.monotonic() > deadline:
                                    self.fail("mock command did not start")
                                time.sleep(0.01)
                            # Like Ctrl+C, deliver the signal to the foreground group.
                            os.killpg(process.pid, sig)
                            _, stderr = process.communicate(timeout=3)
                            self.assertEqual(process.returncode, 128 + sig, stderr)
                            self.assertEqual(self.calls()[-1]["phase"], "cleanup")
                            self.assert_cleanup()
                        finally:
                            try:
                                os.killpg(process.pid, signal.SIGKILL)
                            except ProcessLookupError:
                                pass
                            process.communicate()

    def test_interrupting_cleanup_does_not_start_another_resume(self):
        process = subprocess.Popen(
            [str(self.root / "hack/k8s-reconcile.sh"), "test-cluster"],
            env={**self.env, "MOCK_BLOCK": "cleanup", "MOCK_FAILURES": '{"reconcile": 42}'},
            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
            text=True, start_new_session=True,
        )
        try:
            deadline = time.monotonic() + 5
            while not self.marker.exists():
                if process.poll() is not None or time.monotonic() > deadline:
                    self.fail("cleanup did not start")
                time.sleep(0.01)
            os.killpg(process.pid, signal.SIGINT)
            process.communicate(timeout=3)
            self.assertNotEqual(process.returncode, 0)
            self.assert_cleanup()
        finally:
            try:
                os.killpg(process.pid, signal.SIGKILL)
            except ProcessLookupError:
                pass
            process.communicate()


if __name__ == "__main__":
    unittest.main(verbosity=2)
