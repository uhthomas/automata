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
	metadata: name:      "\(#Name)-default"
	spec: mergeGateways: true
}]
