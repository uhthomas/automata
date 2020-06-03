# 6f.io k8s manifests

## Setup

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

## Creating secrets

```sh
$ kubectl create secret generic kipp --dry-run=client --from-file=filesystem=some-file -o yaml | kubeseal --controller-name sealed-secrets -o yaml > secrets/kipp.yaml
```

### Creating the Linkerd2 trust anchor
```sh
$ step certificate create identity.linkerd.cluster.local ca.crt ca.key \
    --profile root-ca \
    --no-password \
    --insecure
$ kubectl create secret tls linkerd-trust-anchor \
    --dry-run=client \
    --cert=ca.crt \
    --key=ca.key \
    --namespace=linkerd -o yaml \
    | kubeseal --controller-name sealed-secrets -o yaml \
    > clusters/casper/linkerd/linkerd2/sealed-secret.yaml
```