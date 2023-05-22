package dragonfly_operator_system

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
	metadata: name: "\(#Name)-controller-manager-metrics-service"
	spec: {
		ports: [{
			name:       "https"
			port:       8443
			targetPort: "https"
		}]
		selector: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/component": "controller-manager"
		}
	}
}]
