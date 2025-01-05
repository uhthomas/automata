# Node Problem Detector

https://github.com/kubernetes/node-problem-detector

Imported with:

```sh
❯ helm template -n node-problem-detector node-problem-detector deliveryhero/node-problem-detector --set="metrics.enabled=true" --set="metrics.serviceMonitor.enabled=true" > out.yaml
❯ cue import -R -l "strings.ToLower(kind)" --list out.yaml
```
