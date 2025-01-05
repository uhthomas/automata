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
}]
