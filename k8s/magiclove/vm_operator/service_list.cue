package vm_operator

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
			port:       8080
			targetPort: "http"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}, {
	metadata: name: "\(#Name)-webhook"
	spec: {
		ports: [{
			name:       "https"
			port:       443
			targetPort: "https"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
