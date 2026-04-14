package kaniop

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
			name:       "metrics"
			port:       8080
			targetPort: "metrics"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}, {
	metadata: name: "\(#Name)-webhook"
	spec: {
		ports: [{
			name:       "webhook"
			port:       8443
			targetPort: "webhook"
			protocol:   v1.#ProtocolTCP
		}]
		selector: "app.kubernetes.io/name": "\(#Name)-webhook"
	}
}]
