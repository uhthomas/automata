package ingress_nginx

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "ingress-nginx"
	}]
}

items: namespaceList.items +
	serviceAccountList.items +
	configMapList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items +
	roleList.items +
	roleBindingList.items +
	serviceList.items +
	deploymentList.items +
	jobList.items +
	validatingWebhookConfigurationList.items
