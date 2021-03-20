package node_exporter

import "k8s.io/api/core/v1"

service: [...v1.#Service]

service: [{
	apiVersion: "v1"
	kind:       "Service"
	metadata: annotations: "prometheus.io/scrape": "true"
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
