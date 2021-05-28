package prometheus_operator

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
	spec: {
		clusterIP: "None"
		ports: [{
			name:       "http"
			port:       8080
			targetPort: "http"
		}]
		selector: {
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/name":      "prometheus-operator"
		}
	}
}]
