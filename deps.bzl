load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def dependencies():
    http_archive(
        name = "bazel_gazelle",
        sha256 = "727f3e4edd96ea20c29e8c2ca9e8d2af724d8c7778e7923a854b2c80952bc405",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.30.0/bazel-gazelle-v0.30.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.30.0/bazel-gazelle-v0.30.0.tar.gz",
        ],
    )
    http_archive(
        name = "com_github_bazelbuild_buildtools",
        sha256 = "76f96aa30635b0566bee078aeff822ec6220f3801c69b9f16f689cd7da901ec8",
        strip_prefix = "buildtools-6.1.1",
        urls = ["https://github.com/bazelbuild/buildtools/archive/6.1.1.tar.gz"],
    )
    http_archive(
        name = "com_github_tnarg_rules_cue",
        # sha256 = "3e067cf11aff8a08cec42ad6c8b37cb84f9656fa48192c17b5795016d6fbee41",
        strip_prefix = "rules_cue-f85546145bab07a5cada175e74a736bee82ace68",
        urls = ["https://github.com/tnarg/rules_cue/archive/f85546145bab07a5cada175e74a736bee82ace68.tar.gz"],
    )
    http_archive(
        name = "rules_proto",
        sha256 = "5d4cd6780634eb2ecafa091df8be8009d395f70a02f722e07e063883dd8af861",
        strip_prefix = "rules_proto-493169c1199dc21b9da860f7040a4502aa174676",
        urls = ["https://github.com/bazelbuild/rules_proto/archive/493169c1199dc21b9da860f7040a4502aa174676.tar.gz"],
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
            "https://github.com/bazelbuild/rules_go/releases/download/v0.39.1/rules_go-v0.35.0.zip",
        ],
    )
    http_archive(
        name = "io_bazel_rules_k8s",
        sha256 = "ce5b9bc0926681e2e7f2147b49096f143e6cbc783e71bc1d4f36ca76b00e6f4a",
        strip_prefix = "rules_k8s-0.7",
        urls = ["https://github.com/bazelbuild/rules_k8s/archive/refs/tags/v0.7.tar.gz"],
    )
