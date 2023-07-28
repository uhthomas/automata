load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def container_dependencies():
    container_pull(
        name = "io_docker_index_library_debian_bookworm_slim",
        digest = "sha256:5bbfcb9f36a506f9c9c2fb53205f15f6e9d1f0e032939378ddc049a2d26d651e",
        registry = "index.docker.io",
        repository = "library/debian",
        tag = "bookworm-slim",
    )
    container_pull(
        name = "io_gcr_distroless_base_debian11",
        digest = "sha256:559bc54043fc1429f1b9c4e16f52670c7861b7c7fd4125129c29c924b293c2b2",
        registry = "gcr.io",
        repository = "distroless/base-debian11",
        tag = "latest",
    )
