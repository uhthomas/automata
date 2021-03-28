package loki

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "loki"
			namespace: "loki"
			labels: {
				"app.kubernetes.io/name":      "loki"
				"app.kubernetes.io/instance":  "loki"
				"app.kubernetes.io/version":   "2.2.0"
				"app.kubernetes.io/component": "loki"
			}
		}
	}]
}

items:
	namespaceList.items +
	configMapList.items +
	persistentVolumeClaimList.items +
	serviceList.items +
	deploymentList.items
