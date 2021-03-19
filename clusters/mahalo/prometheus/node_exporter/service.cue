package node_exporter

import "k8s.io/api/core/v1"

service: [...v1.#Service]

service: [{
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "node-exporter"
		annotations: "prometheus.io/scrape": "true"
		labels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/version":   "1.2.2"
			"app.kubernetes.io/component": "node-exporter"
		}
	}
	spec: {
		ports: [{
			name:       "metrics"
			port:       9100
			targetPort: "metrics"
		}]
		selector: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/component": "node-exporter"
		}
	}
}]
