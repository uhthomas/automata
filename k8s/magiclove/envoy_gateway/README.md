# Envoy Gateway

[https://gateway.envoyproxy.io/](https://gateway.envoyproxy.io/)

[https://github.com/envoyproxy/gateway](https://github.com/envoyproxy/gateway)

The certgen job has been removed, cert-manager is used instead.

[https://gateway.envoyproxy.io/docs/install/custom-cert/](https://gateway.envoyproxy.io/docs/install/custom-cert/)

```sh
❯ helm template eg oci://docker.io/envoyproxy/gateway-helm --version v1.7.1 -n envoy-gateway > out.yaml
❯ cue import -l "strings.ToLower(kind)" --list out.yaml
```

CRDs are sourced from the release `install.yaml` (helm doesn't render them):

```sh
❯ curl -sL https://github.com/envoyproxy/gateway/releases/download/v1.7.1/install.yaml -o install.yaml
❯ yq 'select(.kind == "CustomResourceDefinition" and (.metadata.name | test("gateway.envoyproxy.io")))' install.yaml > eg-crds.yaml
❯ cue import -l "strings.ToLower(kind)" --list eg-crds.yaml
```

[https://github.com/envoyproxy/gateway/releases/tag/v1.7.1](https://github.com/envoyproxy/gateway/releases/tag/v1.7.1)

The merged deployment strategy is used to save resources.

[https://gateway.envoyproxy.io/docs/tasks/operations/deployment-mode/#merged-gateways-deployment](https://gateway.envoyproxy.io/docs/tasks/operations/deployment-mode/#merged-gateways-deployment)
