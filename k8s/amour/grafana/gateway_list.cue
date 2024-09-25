package grafana

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
	spec: {
		gatewayClassName: "cilium"
		listeners: [{
			name:     "http"
			port:     80
			protocol: gatewayv1.#HTTPProtocolType
		}]
	}
}]
