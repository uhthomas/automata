load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def container_dependencies():
    container_pull(
        name = "io_docker_index_library_debian_bookworm_slim",
        digest = "sha256:ceac69add95cb9ac0d99d9569350cc36838b76397d986e1ccc284bd034b58a9f",
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
