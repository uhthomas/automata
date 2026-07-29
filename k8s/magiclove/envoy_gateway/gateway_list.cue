package envoy_gateway

import gatewayv1 "sigs.k8s.io/gateway-api/apis/v1"

#GatewayList: gatewayv1.#GatewayList & {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "GatewayList"
	items: [...{
		apiVersion: "gateway.networking.k8s.io/v1"
		kind:       "Gateway"
	}]
}

#GatewayList: items: [{
	metadata: name: "public"
	spec: {
		gatewayClassName: "envoy-gateway"
		allowedListeners: namespaces: from: gatewayv1.#NamespacesFromAll
		// A Gateway requires at least one listener. Application listeners are
		// supplied by ListenerSets in their own namespaces.
		listeners: [{
			name:     "http"
			port:     80
			protocol: gatewayv1.#HTTPProtocolType
			allowedRoutes: namespaces: from: gatewayv1.#NamespacesFromAll
		}]
	}
}]
