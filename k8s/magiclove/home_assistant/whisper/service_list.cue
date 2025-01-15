package whisper

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
			name:       "wyoming"
			port:       10300
			targetPort: "wyoming"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
