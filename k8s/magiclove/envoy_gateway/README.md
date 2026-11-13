# Envoy Gateway data plane

The `public` Gateway and its EnvoyProxy live in the `envoy-gateway` namespace.
Application namespaces attach listeners using ListenerSets. Gateway Namespace
deployment mode keeps the shared Envoy data plane beside the Gateway.

See [the controller update instructions](../envoy_gateway_system/README.md) for
Helm rendering, CRD updates and the patched Envoy image override.

There are currently no Envoy OIDC SecurityPolicies in this cluster. Any future
OIDC policies should retain the default token-cookie encryption: Envoy decrypts
cookies before downstream JWT verification and forwarding to applications.
