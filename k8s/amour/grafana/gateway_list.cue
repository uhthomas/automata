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
	metadata: annotations: "cert-manager.io/cluster-issuer": "self-signed-ca"
	spec: {
		gatewayClassName: "cilium"
		listeners: [{
			name:     "http"
			hostname: "grafana-amour.hipparcos.net"
			port:     80
			protocol: gatewayv1.#HTTPProtocolType
		}, {
			name:     "https"
			hostname: "grafana-amour.hipparcos.net"
			port:     443
			protocol: gatewayv1.#HTTPSProtocolType
			tls: certificateRefs: [{name: "\(#Name)-tls"}]
		}]
	}
}]
