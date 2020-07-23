# 6f.io k8s manifests

## Setup

### Considerations
Flux and helm-operator don't play well with any resources which it didn't
create. Such, the resources should be re-created after setup.

### Install kubectl, fluxctl and helm
```sh
$ sudo pacman -S kubectl fluxctl helm
```

### Install the Sealed Secrets controller, and renew secrets
Any manifest labeled `kind: SealedSecret` must be renewed for the new cluster.
```sh
$ helm upgrade -i sealed-secrets stable/sealed-secrets \
    --namespace kube-system
```

### Install Flux and Helm Operator
```sh
$ helm repo add fluxcd https://charts.fluxcd.io
$ kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/v1.1.0/deploy/crds.yaml
$ kubectl create namespace flux
$ helm upgrade -i flux fluxcd/flux \
    --set git.url=git@github.com:uhthomas/manifests \
    --set git.path=clusters/casper \
    --namespace flux
$ helm upgrade -i helm-operator fluxcd/helm-operator \
    --set git.ssh.secretName=flux-git-deploy \
    --set helm.versions=v3 \
    --namespace flux
```

### Give flux write access to the git repo
Copy the public key, and make a new deploy key with write access on the git repository.
```sh
$ fluxctl identity --k8s-fwd-ns flux
```

---

Flux should then sync the cluster to the state of the git repository.

## Secrets

### Creating

```sh
$ kubectl create secret generic --dry-run=client loki-helm-release --from-file=values.yaml -oyaml -n telemetry | kubeseal --controller-name sealed-secrets -oyaml > sealed-secret.yaml
```

### Viewing

```sh
$ kubectl -n telemetry get secret loki-helm-release -oyaml | yq '.data["values.yaml"]' -r | base64 --decode -
```
