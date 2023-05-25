# Loki

[https://github.com/grafana/loki](https://github.com/grafana/loki)

## Import

```sh
❯ helm repo add grafana https://grafana.github.io/helm-charts
❯ helm template loki grafana/loki -n loki --set=storage.type=s3 --set=test.enabled=false --set=monitoring.selfMonitoring.grafanaAgent.installOperator=false --set=monitoring.lokiCanary.enabled=false --set=monitoring.selfMonitoring.enabled=false > out.yaml
❯ cue import -R -l "strings.ToLower(kind)" --list out.yaml
```
