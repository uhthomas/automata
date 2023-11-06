# gazelle:repository_macro go_deps.bzl%go_dependencies
workspace(name = "com_github_uhthomas_automata")

load("//:deps.bzl", "dependencies")

dependencies()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.21.3")

load("//:go_deps.bzl", "go_dependencies")

go_dependencies()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()

rules_proto_toolchains()

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load("//:container_deps.bzl", "container_dependencies")

container_dependencies()

# load("@io_bazel_rules_k8s//toolchains/kubectl:kubectl_configure.bzl", "kubectl_configure")

# kubectl_configure(
#     name = "k8s_config",
#     kubectl_path = "@io_k8s_kubernetes//cmd/kubectl",
# )

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")

k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s_go_deps.bzl", k8s_go_deps = "deps")

k8s_go_deps(go_version = None)

load("@com_github_tnarg_rules_cue//:go.bzl", cue_go_deps = "go_modules")

cue_go_deps()

load("@com_github_tnarg_rules_cue//cue:deps.bzl", "cue_register_toolchains")

cue_register_toolchains()
