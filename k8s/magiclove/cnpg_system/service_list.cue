package cnpg_system

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
	metadata: name: "cnpg-webhook-service"
	spec: {
		ports: [{
			port:       443
			targetPort: 9443
		}]
		selector: "app.kubernetes.io/name": "cloudnative-pg"
	}
}]
