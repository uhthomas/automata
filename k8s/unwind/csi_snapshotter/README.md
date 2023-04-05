# CSI Snapshotter

https://github.com/kubernetes-csi/external-snapshotter/tree/master

Imported with:

```sh
❯ k kustomize "https://github.com/kubernetes-csi/external-snapshotter/deploy/kubernetes/csi-snapshotter?ref=v6.2.1" > csi.yaml
❯ cue import -R -l "strings.ToLower(kind)" --list csi.yaml
```
