load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def dependencies():
    http_archive(
        name = "bazel_gazelle",
        sha256 = "ecba0f04f96b4960a5b250c8e8eeec42281035970aa8852dda73098274d14a1d",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.29.0/bazel-gazelle-v0.29.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.29.0/bazel-gazelle-v0.29.0.tar.gz",
        ],
    )
    http_archive(
        name = "com_github_bazelbuild_buildtools",
        sha256 = "ca524d4df8c91838b9e80543832cf54d945e8045f6a2b9db1a1d02eec20e8b8c",
        strip_prefix = "buildtools-6.0.1",
        urls = ["https://github.com/bazelbuild/buildtools/archive/6.0.1.tar.gz"],
    )
    http_archive(
        name = "com_github_tnarg_rules_cue",
        # sha256 = "3e067cf11aff8a08cec42ad6c8b37cb84f9656fa48192c17b5795016d6fbee41",
        strip_prefix = "rules_cue-f85546145bab07a5cada175e74a736bee82ace68",
        urls = ["https://github.com/tnarg/rules_cue/archive/f85546145bab07a5cada175e74a736bee82ace68.tar.gz"],
    )
    http_archive(
        name = "rules_proto",
        sha256 = "1357c68ef1c3644cafad6ae1822d99c06b94ef2cd8e01c783968703f61373d18",
        strip_prefix = "rules_proto-71c4fc69900946093ac5c82d81efd19fa522d060",
        urls = ["https://github.com/bazelbuild/rules_proto/archive/71c4fc69900946093ac5c82d81efd19fa522d060.tar.gz"],
    )
    http_archive(
        name = "rules_python",
        sha256 = "cd6730ed53a002c56ce4e2f396ba3b3be262fd7cb68339f0377a45e8227fe332",
        urls = ["https://github.com/bazelbuild/rules_python/releases/download/0.5.0/rules_python-0.5.0.tar.gz"],
    )
    http_archive(
        name = "io_bazel_rules_docker",
        sha256 = "b1e80761a8a8243d03ebca8845e9cc1ba6c82ce7c5179ce2b295cd36f7e394bf",
        urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.25.0/rules_docker-v0.25.0.tar.gz"],
    )
    http_archive(
        name = "io_bazel_rules_go",
        sha256 = "099a9fb96a376ccbbb7d291ed4ecbdfd42f6bc822ab77ae6f1b5cb9e914e94fa",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.35.0/rules_go-v0.35.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.35.0/rules_go-v0.35.0.zip",
        ],
    )
    http_archive(
        name = "io_bazel_rules_k8s",
        sha256 = "ce5b9bc0926681e2e7f2147b49096f143e6cbc783e71bc1d4f36ca76b00e6f4a",
        strip_prefix = "rules_k8s-0.7",
        urls = ["https://github.com/bazelbuild/rules_k8s/archive/refs/tags/v0.7.tar.gz"],
    )
