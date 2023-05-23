load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def container_dependencies():
    container_pull(
        name = "io_docker_index_library_debian_bookworm_slim",
        digest = "sha256:b396b38adb888af839a4b967ba919c49086987126500d6cd8f662531e202d038",
        registry = "index.docker.io",
        repository = "library/debian",
        tag = "bookworm-slim",
    )
    container_pull(
        name = "io_gcr_distroless_base_debian11",
        digest = "sha256:a713d945f4a1a71828d34313456268ffc4f35db85fbbeea45dda99b5547cb0f1",
        registry = "gcr.io",
        repository = "distroless/base-debian11",
        tag = "latest",
    )
