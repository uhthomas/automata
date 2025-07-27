package magiclove

import gatewayv1 "sigs.k8s.io/gateway-api/apis/v1"

#GatewayClassList: gatewayv1.#GatewayClassList & {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "GatewayClassList"
	items: [...{
		apiVersion: "gateway.networking.k8s.io/v1"
		kind:       "GatewayClass"
	}]
}

#GatewayClassList: items: [{
	metadata: name: "cilium"
	spec: {
		controllerName: "io.cilium/gateway-controller"
		description:    "The default Cilium GatewayClass"
	}
}, {
	metadata: name: "envoy-gateway"
	spec: {
		controllerName: "gateway.envoyproxy.io/gatewayclass-controller"
		parametersRef: {
			group:     "gateway.envoyproxy.io"
			kind:      "EnvoyProxy"
			name:      "envoy-gateway-default"
			namespace: "envoy-gateway"
		}
	}
}]
