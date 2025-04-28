package valkey

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
			name:       "valkey"
			port:       6379
			targetPort: "valkey"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
