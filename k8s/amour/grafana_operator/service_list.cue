package grafana_operator

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
			name:       "http-metrics"
			port:       9090
			targetPort: "http-metrics"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
