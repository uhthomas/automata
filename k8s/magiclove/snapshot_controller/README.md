# Snapshot Controller

https://github.com/kubernetes-csi/external-snapshotter/tree/master

Imported with:

```sh
❯ k kustomize "https://github.com/kubernetes-csi/external-snapshotter/client/config/crd?ref=v6.2.1" > crd.yaml
❯ k kustomize "https://github.com/kubernetes-csi/external-snapshotter/deploy/kubernetes/snapshot-controller?ref=v6.2.1" > sc.yaml
❯ cue import -R -l "strings.ToLower(kind)" --list crd.yaml sc.yaml
```
