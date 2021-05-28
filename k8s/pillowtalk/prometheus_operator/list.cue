package prometheus_operator

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"prometheus-operator"
			namespace: "prometheus-operator"
			labels: {
				"app.kubernetes.io/name":      "prometheus-operator"
				"app.kubernetes.io/instance":  "prometheus-operator"
				"app.kubernetes.io/version":   "0.48.0"
				"app.kubernetes.io/component": "controller"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	serviceAccountList.items +
	customResourceDefinitionList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items +
	serviceList.items +
	deploymentList.items
