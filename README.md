# 6f.io k8s manifests

## Authenticate

### Install doctl
```sh
$ yay doctl
```

### Authenticate with doctl
```sh
$ doctl auth init 
```

### Save k8s cluster credentials
```sh
$ doctl kubernetes cluster kubeconfig save <clusterName>
```

## Setup

### Install kubectl, fluxctl and helm
```sh
$ sudo pacman -S kubectl fluxctl helm
```

### Install Flux and Helm Operator
```sh
$ helm repo add fluxcd https://charts.fluxcd.io
$ kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/v1.1.0/deploy/crds.yaml
$ kubectl create namespace flux
$ helm upgrade -i flux fluxcd/flux --set git.url=git@github.com:uhthomas/k8s --namespace flux
$ helm upgrade -i helm-operator fluxcd/helm-operator --set git.ssh.secretName=flux-git-deploy --namespace flux --set helm.versions=v3
```

### Give flux write access to the git repo
Copy the public key, and make a new deploy key with write access on the git repository.
```sh
$ fluxctl identity --k8s-fwd-ns flux
```

---

Flux should then sync the cluster to the state of the git repository.

## Creating secrets

```sh
$ kubectl create secret generic kipp --dry-run=client --from-file=filesystem=some-file -o yaml | kubeseal --controller-name sealed-secrets -o yaml > secrets/kipp.yaml
```
