package cnpg_system

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "cloudnative-pg"
#Namespace: "cnpg-system"
#Version:   "1.25.1"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: string | *#Namespace
			labels: {
				"app.kubernetes.io/name":    string | *#Name
				"app.kubernetes.io/version": "v\(#Version)"
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#ConfigMapList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#MutatingWebhookConfigurationList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#ValidatingWebhookConfigurationList.items,
	// #VMServiceScrapeList.items,
]
