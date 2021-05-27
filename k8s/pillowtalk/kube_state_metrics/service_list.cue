package kube_state_metrics

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
			port:       8080
			targetPort: "http-metrics"
		}, {
			name:       "telemetry"
			port:       8081
			targetPort: "telemetry"
		}]
		selector: {
			"app.kubernetes.io/name":      "kube-state-metrics"
			"app.kubernetes.io/instance":  "kube-state-metrics"
			"app.kubernetes.io/component": "kube-state-metrics"
		}
	}
}]
