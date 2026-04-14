# Snapshot Controller

https://github.com/kubernetes-csi/external-snapshotter/tree/master

Imported with:

```sh
❯ k kustomize "https://github.com/kubernetes-csi/external-snapshotter/client/config/crd?ref=v8.5.0" > crd.yaml
❯ k kustomize "https://github.com/kubernetes-csi/external-snapshotter/deploy/kubernetes/snapshot-controller?ref=v8.5.0" > sc.yaml
❯ cue import -R -l "strings.ToLower(kind)" --list crd.yaml sc.yaml
```
