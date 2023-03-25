package cert_manager

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "cert-manager"
#Namespace: #Name
#Version:   "1.11.0"

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
	// The namespace must be created first.
	#NamespaceList.items,
	// Lexicographic ordering.
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#ConfigMapList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#MutatingWebhookConfigurationList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#ValidatingWebhookConfigurationList.items,
]
