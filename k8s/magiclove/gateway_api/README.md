# Gateway API

This is unlike most other directories in the sense that there is no namespace,
and is only used to organise the CRDs for the Gateway API.

Version: v1.5.1 (experimental, used by Envoy Gateway)

[https://gateway-api.sigs.k8s.io/](https://gateway-api.sigs.k8s.io/)

[https://github.com/kubernetes-sigs/gateway-api](https://github.com/kubernetes-sigs/gateway-api)

To update, fetch the install yaml and convert to cue:

```sh
❯ curl -sL https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.5.1/experimental-install.yaml -o gw.yaml
❯ cue import -l "strings.ToLower(kind)" --list -R gw.yaml
```
