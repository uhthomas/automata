package grafana

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "grafana"
			namespace: "grafana"
			labels: {
				"app.kubernetes.io/name":      "grafana"
				"app.kubernetes.io/instance":  "grafana"
				"app.kubernetes.io/version":   "9.3.6"
				"app.kubernetes.io/component": "grafana"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	configMapList.items +
	deploymentList.items +
	persistentVolumeClaimList.items +
	secretList.items +
	serviceAccountList.items +
	serviceList.items
