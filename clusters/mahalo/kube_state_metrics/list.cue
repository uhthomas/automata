package kube_state_metrics

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "kube-state-metrics"
			namespace: "kube-state-metrics"
			labels: {
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/instance":  "kube-state-metrics"
				"app.kubernetes.io/version":   "2.0.0-rc.0"
				"app.kubernetes.io/component": "kube-state-metrics"
			}
		}
	}]
}

items:
	namespace +
	service_account +
	cluster_role +
	cluster_role_binding +
	service +
	deployment
