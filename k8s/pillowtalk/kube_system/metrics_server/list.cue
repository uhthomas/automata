package metrics_server

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: name: string | *"metrics-server"}]
}

list: items: deploymentList.items +
	serviceList.items +
	apiServiceList.items +
	roleBindingList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items
