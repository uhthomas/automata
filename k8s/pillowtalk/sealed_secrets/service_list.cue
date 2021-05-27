package sealed_secrets

import "k8s.io/api/core/v1"

serviceList: v1.#ServiceList & {
	apiVersion: "v1"
	kind:       "ServiceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Service"
	}]
}

serviceList: items: [{
	metadata: {
		labels: name: "sealed-secrets-controller"
		name: "sealed-secrets-controller"
	}
	spec: {
		ports: [{
			port:       8080
			targetPort: 8080
		}]
		selector: name: "sealed-secrets-controller"
		type: v1.#ServiceTypeClusterIP
	}
}]
