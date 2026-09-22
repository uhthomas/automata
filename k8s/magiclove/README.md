# magiclove

Please follow the documentation for `onepassword-connect` as it is a
prerequisite.

## Deploy

```sh
./hack/k8s-deploy.sh magiclove
```

The command renders and validates the complete graph, publishes it as an OCI
artifact, and asks Flux to reconcile that artifact. The optional second argument
selects the OCI tag and defaults to `main`. Restore production without
publishing a new artifact with `./hack/k8s-reconcile.sh magiclove main`.

Do not invoke `kubectl apply` directly or pipe a partial CUE export to the
cluster.
