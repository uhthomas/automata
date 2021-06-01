package loki

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
	metadata: annotations: "prometheus.io/scrape": "true"
	spec: {
		ports: [{
			name:       "http-metrics"
			port:       3100
			targetPort: "http-metrics"
		}]
		selector: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "loki"
		}
	}
}]
