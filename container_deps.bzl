load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def container_dependencies():
    container_pull(
        name = "io_docker_index_library_debian_bookworm_slim",
        digest = "sha256:719ab80ef51a82a0a3e92a72436d8a8a027b10da6d8eea114db7e44a68c0a32e",
        registry = "index.docker.io",
        repository = "library/debian",
        tag = "bookworm-slim",
    )
    container_pull(
        name = "io_gcr_distroless_base_debian11",
        digest = "sha256:d08c10f03c27271160993f294e0eb120af71217d0cf4587c484cc5b7cb3fe5ee",
        registry = "gcr.io",
        repository = "distroless/base-debian11",
        tag = "latest",
    )
