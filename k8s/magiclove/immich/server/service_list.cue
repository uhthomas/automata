package server

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
			name:       "http"
			port:       80
			targetPort: "http"
		}, {
			name:       "http-metrics"
			port:       8081
			targetPort: "http-metrics"
		}, {
			name:       "smb"
			port:       445
			targetPort: "smb"
		}]
		selector: "app.kubernetes.io/name": #Name
		type: v1.#ServiceTypeLoadBalancer
	}
}]
