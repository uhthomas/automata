load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def container_dependencies():
    container_pull(
        name = "io_docker_index_library_debian_bookworm_slim",
        digest = "sha256:93ff361288a7c365614a5791efa3633ce4224542afb6b53a1790330a8e52fc7d",
        registry = "index.docker.io",
        repository = "library/debian",
        tag = "bookworm-slim",
    )
    container_pull(
        name = "io_gcr_distroless_base_debian11",
        digest = "sha256:6c871aa3c9019984dfd7f520635bd658d740ad20c6268a82faa433f69dfc9a0b",
        registry = "gcr.io",
        repository = "distroless/base-debian11",
        tag = "latest",
    )
