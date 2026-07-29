package grafana

import gatewayv1 "sigs.k8s.io/gateway-api/apis/v1"

#ListenerSetList: gatewayv1.#ListenerSetList & {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "ListenerSetList"
	items: [...{
		apiVersion: "gateway.networking.k8s.io/v1"
		kind:       "ListenerSet"
	}]
}

#ListenerSetList: items: [{
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":            "letsencrypt"
		"external-dns.alpha.kubernetes.io/hostname": "\(#Name)-magiclove.hipparcos.net"
	}
	spec: {
		parentRef: {
			group:     "gateway.networking.k8s.io"
			kind:      "Gateway"
			name:      "public"
			namespace: "envoy-gateway"
		}
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
