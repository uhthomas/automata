package node_exporter

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: "node-exporter"
			labels: {
				"app.kubernetes.io/name":      "prometheus"
				"app.kubernetes.io/instance":  "prometheus"
				"app.kubernetes.io/version":   "1.1.2"
				"app.kubernetes.io/component": "node-exporter"
			}
		}
	}]

}

items:
	service_account +
	role +
	role_binding +
	service +
	daemon_set
