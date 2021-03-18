package node_exporter

import "k8s.io/api/core/v1"

service_account: [...v1.#ServiceAccount]

service_account: [{
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name: "node-exporter"
		labels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/version":   "1.2.2"
			"app.kubernetes.io/component": "node-exporter"
		}
	}
}]
