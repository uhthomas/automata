package node_exporter

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "node-exporter"
			namespace: "node-exporter"
			labels: {
				"app.kubernetes.io/name":      "node-exporter"
				"app.kubernetes.io/instance":  "node-exporter"
				"app.kubernetes.io/version":   "1.1.2"
				"app.kubernetes.io/component": "exporter"
			}
		}
	}]

}

list: items:
	serviceAccountList.items +
	roleList.items +
	roleBindingList.items +
	serviceList.items +
	daemonSetList.items
