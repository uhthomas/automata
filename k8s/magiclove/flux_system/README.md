# Flux

This package contains the Flux bootstrap resources used for OCI-based
delivery. The controller manifests are generated from Flux `v2.9.3` with only
the two required components:

```sh
flux install \
  --version=v2.9.3 \
  --namespace=flux-system \
  --components=source-controller,kustomize-controller \
  --network-policy=true \
  --export
```

The exported resources are represented as typed CUE lists and composed through
the same `#List` convention as the other packages in this repository. The Flux
API types under `cue.mod/gen/github.com/fluxcd` are generated from the pinned
source-controller and kustomize-controller Go modules. Keep the generated Go
type on the left of each conjunction so `cue export` follows the field order of
the original Go structs.

The package also contains one cluster-wide `OCIRepository/magiclove` and
`Kustomization/magiclove`. A single artifact contains the complete Magiclove
delivery graph, keeping CRDs and their consumers in one ordered reconciliation. Split
the graph only if parts of the cluster later need independent release cadence,
access control, or failure isolation.

The OCI package is public, so the cluster pulls it anonymously. The
`OCIRepository` deliberately has no `secretRef`, and no registry credential is
stored in the cluster or Akeyless.

The Kustomization disables garbage collection with `spec.prune: false`.
Resources removed from the delivery graph remain in the cluster and must be
deleted explicitly. It also uses `spec.deletionPolicy: Orphan`, so deleting
the Kustomization itself does not delete the cluster.

The root delivery list defaults every rendered object to
`kustomize.toolkit.fluxcd.io/prune: disabled`, and the Flux bootstrap package
requires the annotation directly. These annotations provide additional
protection if pruning is re-enabled; setting an object's annotation to
`enabled` does not override `spec.prune: false`.

## Publishing

`hack/k8s-push.sh` exports `#List`, sets the self-referential OCI tag, and
pushes the result with the Flux CLI:

```sh
./hack/k8s-push.sh magiclove dev-$USER
```

The workflow in `.github/workflows/k8s-publish.yaml` validates the render on
pull requests. On branch pushes, it grants the automatically supplied
`GITHUB_TOKEN` `packages: write`, uses it to authenticate to GHCR, and pushes
the artifact to the normalized branch tag. No separately provisioned Actions
secret is required.

The `automata/magiclove` package must remain public so source-controller can
pull it without an in-cluster credential.

## Fast local iteration

Install `cue`, `jq`, and the Flux CLI, then authenticate the Flux CLI to GHCR
using the Docker credential store. Pick a tag for your local branch and deploy:

```sh
./hack/k8s-deploy.sh magiclove dev-$USER
# Edit and repeat deploy as needed.
./hack/k8s-reconcile.sh magiclove main
```

`k8s-deploy.sh` is just `k8s-push.sh` followed by `k8s-reconcile.sh`.
All three scripts accept `<cluster> [tag]`, with the tag defaulting to `main`.
Reconciliation patches `OCIRepository/magiclove` to the requested tag and asks
Flux to reconcile it immediately. Do not use `kubectl apply` or send a partial
CUE export to the cluster.

The normal deploy waits up to ten minutes for reconciliation. On failure or
interruption, cleanup only resumes the Kustomization with `--wait=false` and a
ten-second timeout; it does not wait for deployment readiness. Cleanup reports
resume failures and preserves the original exit status (130 for Ctrl+C).
Interrupting cleanup again terminates it without starting another resume.

Run `python3 hack/k8s-reconcile-test.py` to test failure and signal handling
with mocked commands, without publishing an artifact or contacting a cluster.
