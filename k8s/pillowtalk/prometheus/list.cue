package prometheus

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"prometheus"
			namespace: "prometheus"
			labels: {
				"app.kubernetes.io/name":     "prometheus"
				"app.kubernetes.io/instance": "prometheus"
				// actually the prometheus-operator version
				"app.kubernetes.io/version":   "0.48.0"
				"app.kubernetes.io/component": "prometheus"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	serviceAccountList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items +
	prometheusList.items
