# Envoy Gateway

[https://gateway.envoyproxy.io/](https://gateway.envoyproxy.io/)

[https://github.com/envoyproxy/gateway](https://github.com/envoyproxy/gateway)

The certgen job has been removed, cert-manager is used instead.

[https://gateway.envoyproxy.io/docs/install/custom-cert/](https://gateway.envoyproxy.io/docs/install/custom-cert/)

```sh
❯ helm template eg oci://docker.io/envoyproxy/gateway-helm --version v1.9.3 -n envoy-gateway-system --set crds.enabled=false > out.yaml
❯ cue import -l "strings.ToLower(kind)" --list out.yaml
```

Gateway API CRDs are managed separately in `k8s/magiclove/gateway_api`, so the
chart's CRD subchart is disabled above. Envoy Gateway extension CRDs are
sourced from the release `install.yaml`:

```sh
❯ curl -sL https://github.com/envoyproxy/gateway/releases/download/v1.9.3/install.yaml -o install.yaml
❯ yq 'select(.kind == "CustomResourceDefinition" and (.metadata.name | test("gateway.envoyproxy.io")))' install.yaml > eg-crds.yaml
❯ cue import -l "strings.ToLower(kind)" --list eg-crds.yaml
```

[https://github.com/envoyproxy/gateway/releases/tag/v1.9.3](https://github.com/envoyproxy/gateway/releases/tag/v1.9.3)

The matching Gateway API bundle is v1.6.1. Its safe-upgrades admission policy
and binding are managed in `gateway_api` alongside the CRDs. Compare old and new
Helm renders with the same values when updating the controller; version changes
alone do not capture its deployment, RBAC and configuration changes.

The v1.9.3 import includes the service-account/fullname environment variables,
startup probe, writable WASM cache and explicit token mounting from the chart,
plus the new EnvoyProxy status permission. Cert-manager continues to supply the
controller certificate, so the Helm certgen Job remains excluded. The shared
EnvoyProxy explicitly uses `distroless-v1.39.6`, the patched image recommended in
the v1.9.3 release notes. Rate-limit and shutdown-manager images follow the chart.

The controller runs in `envoy-gateway-system`. The sibling
`envoy_gateway` package owns the `envoy-gateway` namespace, the single
`public` Gateway and its EnvoyProxy. Application namespaces attach listeners
to that Gateway with ListenerSets.

Gateway Namespace deployment mode keeps the Envoy data plane beside the
`public` Gateway. `mergeGateways` must remain disabled in this mode.

Do not enable Gateway Namespace mode while the former application Gateways
still exist. Doing so can briefly allocate one LoadBalancer per old Gateway.
Remove the old Envoy Gateways with the old controller stopped before applying
the final ListenerSet-based configuration.
