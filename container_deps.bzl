load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def container_dependencies():
    container_pull(
        name = "io_docker_index_library_debian_bookworm_slim",
        digest = "sha256:5c1586cd384b778f88ece4920aa36d083da02a26ea628036cc20af86f15ed42e",
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
