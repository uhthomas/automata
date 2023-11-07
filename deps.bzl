load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def dependencies():
    http_archive(
        name = "bazel_gazelle",
        sha256 = "d3fa66a39028e97d76f9e2db8f1b0c11c099e8e01bf363a923074784e451f809",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.33.0/bazel-gazelle-v0.33.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.33.0/bazel-gazelle-v0.33.0.tar.gz",
        ],
    )
    http_archive(
        name = "com_github_bazelbuild_buildtools",
        sha256 = "42968f9134ba2c75c03bb271bd7bb062afb7da449f9b913c96e5be4ce890030a",
        strip_prefix = "buildtools-6.3.3",
        urls = ["https://github.com/bazelbuild/buildtools/archive/v6.3.3.tar.gz"],
    )
    http_archive(
        name = "com_github_tnarg_rules_cue",
        sha256 = "88a52126d169ba7090335f872f6b42b9c8d625d5b362bf781d82efc553e37af3",
        strip_prefix = "rules_cue-d7360f88423830afe3b4f2e334e9a6456d58f994",
        urls = ["https://github.com/uhthomas/rules_cue/archive/d7360f88423830afe3b4f2e334e9a6456d58f994.tar.gz"],
    )
    http_archive(
        name = "rules_proto",
        sha256 = "11f5ee3bf7142b432c7c877fb93b3a18afa2c5bc7a296fc59f71ce10999a2fa5",
        strip_prefix = "rules_proto-4e32e70a700dac5b41e05ed6e9429e49ebb1a4ee",
        urls = ["https://github.com/bazelbuild/rules_proto/archive/4e32e70a700dac5b41e05ed6e9429e49ebb1a4ee.tar.gz"],
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
        sha256 = "91585017debb61982f7054c9688857a2ad1fd823fc3f9cb05048b0025c47d023",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.42.0/rules_go-v0.42.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.42.0/rules_go-v0.42.0.zip",
        ],
    )
    http_archive(
        name = "io_bazel_rules_k8s",
        sha256 = "ce5b9bc0926681e2e7f2147b49096f143e6cbc783e71bc1d4f36ca76b00e6f4a",
        strip_prefix = "rules_k8s-0.7",
        urls = ["https://github.com/bazelbuild/rules_k8s/archive/refs/tags/v0.7.tar.gz"],
    )
