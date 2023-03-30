# Node Feature Discovery

https://github.com/kubernetes-sigs/node-feature-discovery


Imported with:

```sh
❯ k kustomize "https://github.com/kubernetes-sigs/node-feature-discovery/deployment/overlays/default?ref=v0.12.1" > out.yaml
❯ cue import -R -l "strings.ToLower(kind)" --list out.yaml
```
