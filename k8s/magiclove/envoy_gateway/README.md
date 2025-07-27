# Envoy Gateway

[https://gateway.envoyproxy.io/](https://gateway.envoyproxy.io/)

[https://github.com/envoyproxy/gateway](https://github.com/envoyproxy/gateway)
T
The certgen job has been removed, cert-manager is used instead.

[https://gateway.envoyproxy.io/docs/install/custom-cert/](https://gateway.envoyproxy.io/docs/install/custom-cert/)

```sh
❯ helm template eg oci://docker.io/envoyproxy/gateway-helm --version v1.4.2 -n envoy-gateway > out.yaml
Pulled: docker.io/envoyproxy/gateway-helm:v1.4.2
Digest: sha256:02bd3e316d3c333e34baf01ad784fb91a5c5a3ac546a23977f18f30315177749
❯ cue import -l "strings.ToLower(kind)" --list out.yaml
```

CRDs:

[https://github.com/envoyproxy/gateway/releases/tag/v1.4.2](https://github.com/envoyproxy/gateway/releases/tag/v1)

The merged deployment strategy is used to save resources.

[https://gateway.envoyproxy.io/docs/tasks/operations/deployment-mode/#merged-gateways-deployment](https://gateway.envoyproxy.io/docs/tasks/operations/deployment-mode/#merged-gateways-deployment)
