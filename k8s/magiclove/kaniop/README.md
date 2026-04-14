# Kaniop

[https://github.com/pando85/kaniop](https://github.com/pando85/kaniop)

```sh
❯ helm template kaniop oci://ghcr.io/pando85/helm-charts/kaniop \
    --version 0.5.8 \
    -n kaniop \
    --set metrics.enabled=true \
    --set metrics.prometheusRules.enabled=true \
    --set webhook.enabled=true \
    --set webhook.certManager.enabled=true \
    --set webhook.patch.enabled=false > out.yaml
❯ cue import -l "strings.ToLower(kind)" --list out.yaml
```

CRDs:

```sh
❯ helm show crds oci://ghcr.io/pando85/helm-charts/kaniop --version 0.5.8 > crds.yaml
❯ cue import -l "strings.ToLower(kind)" --list crds.yaml
```

Metrics are exposed via VMServiceScrape and alert rules via VMRule (not the
helm chart's ServiceMonitor/PrometheusRule).

The webhook uses cert-manager with a self-signed issuer chain (not the helm
chart's certgen patch job).
