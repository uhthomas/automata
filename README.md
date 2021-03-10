# Automata
Monorepo for 6f.io and subsidiaries.

## Getting started

### Prerequisites
* [Bazel](https://build.bazel)

### Apply manifests

```sh
# the managed-by label is pre-applied, so pruning is safe
bazel run //clusters:objects.apply -- --prune
```

## Starting a new cluster

### Create a cluster role for GitHub Actions
Create a service account, bind to a cluster role and store the service account's
token as a repository secret.
```sh
$ k -n default create serviceaccount automata
$ k create clusterrolebinding automata --clusterrole cluster-admin --serviceaccount=default:automata
$ k get secret $(k get sa automata -ojson | jq -r '.secrets[0].name') -oyaml
# token
$ k get secret $(k get sa automata -ojson | jq -r '.secrets[0].name') -ojson | jq -r '.data.token'| base64 --decode
# ca.crt
k get secret $(k get sa automata -ojson | jq -r '.secrets[0].name') -ojson | jq -r '.data["ca.crt"]' | base64 --decode | xxd -p | tr -d \\n
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
