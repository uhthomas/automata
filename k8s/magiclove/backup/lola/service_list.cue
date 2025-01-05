package lola

import "k8s.io/api/core/v1"

#ServiceList: v1.#ServiceList & {
	apiVersion: "v1"
	kind:       "ServiceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Service"
	}]
}

#ServiceList: items: [{
	metadata: name: "\(#Name)-syncthing"
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}, {
			name:       "sync"
			port:       22000
			targetPort: "sync"
		}, {
			name:       "sync-udp"
			port:       22000
			targetPort: "sync-udp"
			protocol:   v1.#ProtocolUDP
		}, {
			name:       "discovery"
			port:       21027
			targetPort: "discovery"
			protocol:   v1.#ProtocolUDP
		}]
		selector: "app.kubernetes.io/name": "\(#Name)-syncthing"
		type: v1.#ServiceTypeLoadBalancer
	}
}]
