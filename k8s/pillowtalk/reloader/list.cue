package reloader

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"reloader"
			namespace: "reloader"
			labels: {
				"app.kubernetes.io/name":     "reloader"
				"app.kubernetes.io/instance": "reloader"
				"app.kubernetes.io/version":   "0.0.90"
				"app.kubernetes.io/component": "reloader"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	serviceAccountList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items +
	serviceList.items +
	deploymentList.items +

        // CRDs
        serviceMonitorList.items
