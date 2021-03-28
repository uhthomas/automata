package cert_manager

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: string | *"cert-manager"
	}]
}

items: namespaceList.items +
	serviceAccountList.items +
	customResourceDefinitionList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items +
	roleList.items +
	roleBindingList.items +
	serviceList.items +
	deploymentList.items +
	validatingWebhookConfigurationList.items +
	mutatingWebhookConfigurationList.items
