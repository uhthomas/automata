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

The root delivery list defaults every rendered object to
`kustomize.toolkit.fluxcd.io/prune: disabled`. This prevents an object omitted
by accident from being garbage-collected. Flux v1.9.4 treats this skip as
settled and removes the omitted object from its inventory, however, so use the
annotation as a deletion guard rather than an inventory or cleanup ledger. The
Flux bootstrap package also requires the annotation directly, so it remains
protected if the root composition changes.

Intentional deletion is a two-revision operation. First override the object's
annotation to `enabled` while it is still present and deploy that revision.
Only remove the object from the graph in a later revision. This makes deletion
an explicit, reviewable state transition instead of a side effect of omission.
The Kustomization uses `spec.deletionPolicy: Orphan`, so deleting the
Kustomization itself does not delete the cluster.

## Publishing

`hack/k8s-push.sh` exports `#List`, sets the self-referential OCI tag, and
pushes the result with the Flux CLI:

```sh
./hack/k8s-push.sh dev-$USER
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
./hack/k8s-deploy.sh dev-$USER
# Edit and repeat deploy as needed.
./hack/k8s-reconcile.sh main
```

`k8s-deploy.sh` is just `k8s-push.sh` followed by `k8s-reconcile.sh`.
Reconciliation patches `OCIRepository/magiclove` to the requested tag and asks
Flux to reconcile it immediately. Do not use `kubectl apply` or send a partial
CUE export to the cluster.
