package kipp

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "kipp"
			namespace: "kipp"
			labels: {
				"app.kubernetes.io/name":      "kipp"
				"app.kubernetes.io/instance":  "kipp"
				"app.kubernetes.io/version":   "0.2.1"
				"app.kubernetes.io/component": "kipp"
			}
		}
	}]
}

items:
	namespace +
	sealed_secret +
	service +
	deployment +
	horizontal_pod_autoscaler +
	ingress
