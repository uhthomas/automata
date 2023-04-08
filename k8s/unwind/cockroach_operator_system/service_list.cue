package cockroach_operator_system

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
	metadata: {
		name: "cockroach-operator-webhook-service"
		labels: "control-plane": "cockroach-operator"
	}
	spec: {
		ports: [{
			port:       443
			targetPort: 9443
		}]
		selector: app: "cockroach-operator"
	}
}]
