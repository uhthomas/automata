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
			name:       "grpc"
			port:       8081
			targetPort: "grpc"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
