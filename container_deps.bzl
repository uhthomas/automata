load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def container_dependencies():
    container_pull(
        name = "io_docker_index_library_debian_bookworm_slim",
        digest = "sha256:993f5593466f84c9200e3e877ab5902dfc0e4a792f291c25c365dbe89833411f",
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
