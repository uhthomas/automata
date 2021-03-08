# Automata
Monorepo for 6f.io and subsidiaries.

## Getting started

### Prerequisites
* [Bazel](https://build.bazel)

### Apply manifests

```sh
# the managed-by label is pre-applied, so pruning is safe
bazel run //clusters/desire:object.apply -- --prune
```

## Starting a new cluster

### Considerations
Helm-operator doesn't play well with any resources which it didn't
create. Such, the resources should be re-created after setup.

### Install kubectl and helm
```sh
$ sudo pacman -S kubectl helm
```

### Install the Sealed Secrets controller, and renew secrets
Any manifest labeled `kind: SealedSecret` must be renewed for the new cluster.
```sh
$ helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
$ helm upgrade -i sealed-secrets sealed-secrets/sealed-secrets \
    --namespace kube-system
```

### Install Helm Operator
```sh
$ helm repo add fluxcd https://charts.fluxcd.io
$ k apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/v1.2.0/deploy/crds.yaml
$ k create namespace flux
$ helm upgrade -i helm-operator fluxcd/helm-operator \
    -n helm-operator \
    --set helm.versions=v3
```

### Create a cluster role for GitHub Actions
Create a service account, bind to a cluster role and store the service account's
token as a repository secret.
```sh
$ k --namespace default create serviceaccount automata
$ k create clusterrolebinding automata --clusterrole cluster-admin --serviceaccount=default:automata
$ k get secret $(k get sa automata -ojson | jq -r '.secrets[0].name') -oyaml
```

---

## Secrets

### Creating

```sh
$ k create secret generic --dry-run=client loki-helm-release --from-file=values.yaml -oyaml -n telemetry | kubeseal --controller-name sealed-secrets -oyaml > sealed-secret.yaml
```

### Viewing

```sh
$ k -n telemetry get secret loki-helm-release -oyaml | yq '.data["values.yaml"]' -r | base64 --decode -
```
