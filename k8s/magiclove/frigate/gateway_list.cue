package frigate

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
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":            "letsencrypt"
		"external-dns.alpha.kubernetes.io/hostname": "\(#Name)-magiclove.hipparcos.net"
	}
	spec: {
		gatewayClassName: "envoy-gateway"
		listeners: [{
			name:     "http"
			hostname: "\(#Name)-magiclove.hipparcos.net"
			port:     80
			protocol: gatewayv1.#HTTPProtocolType
		}, {
			name:     "https"
			hostname: "\(#Name)-magiclove.hipparcos.net"
			port:     443
			protocol: gatewayv1.#HTTPSProtocolType
			tls: certificateRefs: [{name: "\(#Name)-tls"}]
		}]
	}
}]
