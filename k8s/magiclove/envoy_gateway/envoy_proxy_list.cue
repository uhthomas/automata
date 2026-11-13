package envoy_gateway

import envoygatewayv1 "github.com/envoyproxy/gateway/api/v1alpha1"

#EnvoyProxyList: envoygatewayv1.#EnvoyProxyList & {
	apiVersion: "gateway.envoyproxy.io/v1alpha1"
	kind:       "EnvoyProxyList"
	items: [...{
		apiVersion: "gateway.envoyproxy.io/v1alpha1"
		kind:       "EnvoyProxy"
	}]
}

#EnvoyProxyList: items: [{
	metadata: name: "\(#Name)-default"
	spec: provider: {
		type: "Kubernetes"
		kubernetes: envoyDeployment: {
			// Gateway 1.9.3 defaults to Envoy 1.39.5, whose distroless image
			// still trusts the affected eMudhra CA roots. Override to 1.39.6
			// until Gateway's bundled default includes the trust-store fix.
			container: image: "docker.io/envoyproxy/envoy:distroless-v1.39.6"
		}
	}
}]
