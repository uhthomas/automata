package webhook

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
			name:       "webhook"
			port:       443
			targetPort: "webhook"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
