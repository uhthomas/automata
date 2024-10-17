load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def container_dependencies():
    container_pull(
        name = "io_docker_index_library_debian_bookworm_slim",
        digest = "sha256:d83056144b2dd301730d2739635c8cbdeaaae20d6887146434184f8c060f03ce",
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
