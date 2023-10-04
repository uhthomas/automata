load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def container_dependencies():
    container_pull(
        name = "io_docker_index_library_debian_bookworm_slim",
        digest = "sha256:94882f177083c7fa6764b9ef2a86ed3c29c99593b34d5441648a7fb3c0cd10ec",
        registry = "index.docker.io",
        repository = "library/debian",
        tag = "bookworm-slim",
    )
    container_pull(
        name = "io_gcr_distroless_base_debian11",
        digest = "sha256:a17ac8990b4395aab186b9538ca04715d2a7408dfd2b6473ff7b16d098d0cb09",
        registry = "gcr.io",
        repository = "distroless/base-debian11",
        tag = "latest",
    )
