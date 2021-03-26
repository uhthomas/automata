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
        sha256 = "afdc3f50adfcd29474110e054e8a934317d33bfd1f5def287d4d6e0f8430b4bf",
        strip_prefix = "rules_cue-d776b924f7568c0f33ab68ee5f90d45efb200ed9",
        urls = ["https://github.com/uhthomas/rules_cue/archive/d776b924f7568c0f33ab68ee5f90d45efb200ed9.tar.gz"],
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
        sha256 = "9c104580ea36dc93c91e5b7d5544dacfc823a5dca9ae0f4bc2f677b5599913d5",
        strip_prefix = "rules_docker-8c3a8110a0c519929a7e79c39ac345a0f8c74d04",
        urls = ["https://github.com/bazelbuild/rules_docker/archive/8c3a8110a0c519929a7e79c39ac345a0f8c74d04.tar.gz"],
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
