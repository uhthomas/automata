load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def dependencies():
    http_archive(
        name = "bazel_gazelle",
        sha256 = "222e49f034ca7a1d1231422cdb67066b885819885c356673cb1f72f748a3c9d4",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.22.3/bazel-gazelle-v0.22.3.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.22.3/bazel-gazelle-v0.22.3.tar.gz",
        ],
    )
    http_archive(
        name = "com_github_bazelbuild_buildtools",
        sha256 = "c28eef4d30ba1a195c6837acf6c75a4034981f5b4002dda3c5aa6e48ce023cf1",
        strip_prefix = "buildtools-4.0.1",
        urls = ["https://github.com/bazelbuild/buildtools/archive/4.0.1.tar.gz"],
    )
    http_archive(
        name = "com_github_tnarg_rules_cue",
        sha256 = "a22bb62dbe4086fbb4fde5be0e36b773ee88edb0330dbb8595c03293b0b4b709",
        strip_prefix = "rules_cue-46863d61bf1fc3fab38033642a541d4fb82bf71b",
        urls = ["https://github.com/uhthomas/rules_cue/archive/46863d61bf1fc3fab38033642a541d4fb82bf71b.tar.gz"],
    )
    http_archive(
        name = "rules_proto",
        sha256 = "9fc210a34f0f9e7cc31598d109b5d069ef44911a82f507d5a88716db171615a8",
        strip_prefix = "rules_proto-f7a30f6f80006b591fa7c437fe5a951eb10bcbcf",
        urls = ["https://github.com/bazelbuild/rules_proto/archive/f7a30f6f80006b591fa7c437fe5a951eb10bcbcf.tar.gz"],
    )
    http_archive(
        name = "rules_python",
        sha256 = "b6d46438523a3ec0f3cead544190ee13223a52f6a6765a29eae7b7cc24cc83a0",
        urls = ["https://github.com/bazelbuild/rules_python/releases/download/0.1.0/rules_python-0.1.0.tar.gz"],
    )
    http_archive(
        name = "io_bazel_rules_docker",
        sha256 = "893726fd83049cece8bfec873091c43877449f28987adf5c13b17801ecf0a788",
        strip_prefix = "rules_docker-e15c9ebf203b7fa708e69ff5f1cdcf427d7edf6f",
        urls = ["https://github.com/bazelbuild/rules_docker/archive/e15c9ebf203b7fa708e69ff5f1cdcf427d7edf6f.tar.gz"],
    )
    http_archive(
        name = "io_bazel_rules_go",
        sha256 = "7904dbecbaffd068651916dce77ff3437679f9d20e1a7956bff43826e7645fcc",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.25.1/rules_go-v0.25.1.tar.gz",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.25.1/rules_go-v0.25.1.tar.gz",
        ],
    )
    http_archive(
        name = "io_bazel_rules_k8s",
        sha256 = "51f0977294699cd547e139ceff2396c32588575588678d2054da167691a227ef",
        strip_prefix = "rules_k8s-0.6",
        urls = ["https://github.com/bazelbuild/rules_k8s/archive/v0.6.tar.gz"],
    )
