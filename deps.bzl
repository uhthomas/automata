load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def dependencies():
    http_archive(
        name = "bazel_gazelle",
        sha256 = "448e37e0dbf61d6fa8f00aaa12d191745e14f07c31cabfa731f0c8e8a4f41b97",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.28.0/bazel-gazelle-v0.28.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.28.0/bazel-gazelle-v0.28.0.tar.gz",
        ],
    )
    http_archive(
        name = "com_github_bazelbuild_buildtools",
        sha256 = "d368c47bbfc055010f118efb2962987475418737e901f7782d2a966d1dc80296",
        strip_prefix = "buildtools-4.2.5",
        urls = ["https://github.com/bazelbuild/buildtools/archive/4.2.5.tar.gz"],
    )
    http_archive(
        name = "com_github_tnarg_rules_cue",
        sha256 = "3e067cf11aff8a08cec42ad6c8b37cb84f9656fa48192c17b5795016d6fbee41",
        strip_prefix = "rules_cue-daadedab2f4db94580c89139a4cb1617db6ca3b1",
        urls = ["https://github.com/uhthomas/rules_cue/archive/daadedab2f4db94580c89139a4cb1617db6ca3b1.tar.gz"],
    )
    http_archive(
        name = "rules_proto",
        sha256 = "c4ebe86f6b8d13ca5a10fdff4008d24788b3c6dd17e141a6f8ac381ff40c4585",
        strip_prefix = "rules_proto-b5e5fc85f70cf6bbef66c69b679c86168ad1bea6",
        urls = ["https://github.com/bazelbuild/rules_proto/archive/b5e5fc85f70cf6bbef66c69b679c86168ad1bea6.tar.gz"],
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
