package node_exporter

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
	metadata: annotations: "prometheus.io/scrape": "true"
	spec: {
		ports: [{
			name:       "http-metrics"
			port:       9100
			targetPort: "http-metrics"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
