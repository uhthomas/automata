load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def container_dependencies():
    container_pull(
        name = "io_docker_index_library_debian_bookworm_slim",
        digest = "sha256:d6a343a9b7faf367bd975cadb5c9af51874a8ecf1a2b2baa96877d578ac96722",
        registry = "index.docker.io",
        repository = "library/debian",
        tag = "bookworm-slim",
    )
    container_pull(
        name = "io_gcr_distroless_base_debian11",
        digest = "sha256:84bb9d5e7d4dc9a21460c376fe32f3adfc333ff4b32df1c7c50a30cb2e282d7a",
        registry = "gcr.io",
        repository = "distroless/base-debian11",
        tag = "latest",
    )
