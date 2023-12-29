load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def dependencies():
    http_archive(
        name = "bazel_gazelle",
        sha256 = "32938bda16e6700063035479063d9d24c60eda8d79fd4739563f50d331cb3209",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.35.0/bazel-gazelle-v0.35.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.35.0/bazel-gazelle-v0.35.0.tar.gz",
        ],
    )
    http_archive(
        name = "com_github_bazelbuild_buildtools",
        sha256 = "05c3c3602d25aeda1e9dbc91d3b66e624c1f9fdadf273e5480b489e744ca7269",
        strip_prefix = "buildtools-6.4.0",
        urls = ["https://github.com/bazelbuild/buildtools/archive/v6.4.0.tar.gz"],
    )
    http_archive(
        name = "com_github_tnarg_rules_cue",
        sha256 = "88a52126d169ba7090335f872f6b42b9c8d625d5b362bf781d82efc553e37af3",
        strip_prefix = "rules_cue-d7360f88423830afe3b4f2e334e9a6456d58f994",
        urls = ["https://github.com/uhthomas/rules_cue/archive/d7360f88423830afe3b4f2e334e9a6456d58f994.tar.gz"],
    )
    http_archive(
        name = "rules_proto",
        sha256 = "f5ae0e582238fcd4ea3d0146a3f5f3db9517f8fe24491eab3c105ace53aad1bb",
        strip_prefix = "rules_proto-f9b0b880d1e10e18daeeb168cef9d0f8316fdcb5",
        urls = ["https://github.com/bazelbuild/rules_proto/archive/f9b0b880d1e10e18daeeb168cef9d0f8316fdcb5.tar.gz"],
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
        sha256 = "b6828eb2d03bb5ef76f2077f8670b211fe792e77ddb83450ea9f887df04db9c7",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.44.1/rules_go-v0.44.1.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.44.1/rules_go-v0.44.1.zip",
        ],
    )
    http_archive(
        name = "io_bazel_rules_k8s",
        sha256 = "ce5b9bc0926681e2e7f2147b49096f143e6cbc783e71bc1d4f36ca76b00e6f4a",
        strip_prefix = "rules_k8s-0.7",
        urls = ["https://github.com/bazelbuild/rules_k8s/archive/refs/tags/v0.7.tar.gz"],
    )
