# Envoy Gateway

The controller runs in `envoy-gateway-system`. The sibling `envoy_gateway`
package owns the `envoy-gateway` namespace, the single `public` Gateway and
its EnvoyProxy. Application namespaces attach listeners to that Gateway with
ListenerSets.

Gateway Namespace deployment mode keeps the Envoy data plane beside the
`public` Gateway. `mergeGateways` must remain disabled in this mode.

Do not enable Gateway Namespace mode while the former application Gateways
still exist. Doing so can briefly allocate one LoadBalancer per old Gateway.
Remove the old Envoy Gateways with the old controller stopped before applying
the final ListenerSet-based configuration.
