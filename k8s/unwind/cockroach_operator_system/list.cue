package cockroach_operator_system

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "cockroach-operator"
#Namespace: "cockroach-operator-system"
#Version:   "2.10.0"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: string | *#Namespace
			labels: {
				"app.kubernetes.io/name":    string | *#Name
				"app.kubernetes.io/version": string | *#Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#MutatingWebhookConfigurationList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#ValidatingWebhookConfigurationList.items,
]
