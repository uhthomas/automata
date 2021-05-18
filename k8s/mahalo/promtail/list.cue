package promtail

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "promtail"
			namespace: "promtail"
			labels: {
				"app.kubernetes.io/name":      "promtail"
				"app.kubernetes.io/instance":  "promtail"
				"app.kubernetes.io/version":   "2.2.0"
				"app.kubernetes.io/component": "promtail"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	serviceAccountList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items +
	configMapList.items +
	daemonSetList.items
