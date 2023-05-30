# KubeVirt

[https://kubevirt.io/](https://kubevirt.io/).

```sh
❯ curl -LOfs https://github.com/kubevirt/kubevirt/releases/download/v0.59.0/kubevirt-operator.yaml
❯ cue import -R -l "strings.ToLower(kind)" --list kubevirt-operator.yaml
❯ curl -LOfs https://github.com/kubevirt/kubevirt/releases/download/v0.59.0/kubevirt-cr.yaml
❯ cue import -R -l "strings.ToLower(kind)" --list kubevirt-cr.yaml
```
