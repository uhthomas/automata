package envoy_gateway

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
	spec: {
		ports: [{
			name: "webhook"
			port: 9443
		}, {
			name: "grpc"
			port: 18000
		}, {
			name: "ratelimit"
			port: 18001
		}, {
			name: "wasm"
			port: 18002
		}, {
			name: "metrics"
			port: 19001
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
