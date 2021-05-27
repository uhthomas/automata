package sealed_secrets

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "sealed-secrets"
	}]
}

list: items:
	namespaceList.items +
	serviceAccountList.items +
	customResourceDefinitionList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items +
	roleList.items +
	roleBindingList.items +
	serviceList.items +
	deploymentList.items
