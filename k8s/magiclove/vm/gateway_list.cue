package vm

import gatewayv1 "sigs.k8s.io/gateway-api/apis/v1"

#GatewayList: gatewayv1.#GatewayList & {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "GatewayList"
	items: [...{
		apiVersion: "gateway.networking.k8s.io/v1"
		kind:       "Gateway"
	}]
}

_#Gateways: [
	"vmagent",
	"vmalert",
	"vmalertmanager",
	"vmsingle",
]

#GatewayList: items: [for gateway in _#Gateways {
	metadata: {
		name: gateway
		annotations: {
			"cert-manager.io/cluster-issuer":            "letsencrypt"
			"external-dns.alpha.kubernetes.io/hostname": "\(gateway)-magiclove.hipparcos.net"
		}
	}
	spec: {
		gatewayClassName: "envoy-gateway"
		listeners: [{
			name:     "http"
			hostname: "\(gateway)-magiclove.hipparcos.net"
			port:     80
			protocol: gatewayv1.#HTTPProtocolType
		}, {
			name:     "https"
			hostname: "\(gateway)-magiclove.hipparcos.net"
			port:     443
			protocol: gatewayv1.#HTTPSProtocolType
			tls: certificateRefs: [{name: "\(gateway)-tls"}]
		}]
	}
}]
