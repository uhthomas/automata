# Reloader

[https://github.com/stakater/Reloader](https://github.com/stakater/Reloader)

The resources are based on the standard Helm installation. To regenerate the
upstream resources:

```sh
❯ helm repo add stakater https://stakater.github.io/stakater-charts
❯ helm repo update
❯ helm template reloader stakater/reloader \
    --version 2.2.12 \
    --namespace reloader \
    --set fullnameOverride=reloader > out.yaml
❯ cue import -l "strings.ToLower(kind)" --list out.yaml
```

The namespace, container security hardening, resource settings and
`VMPodScrape` are maintained locally.
