package wireguard_operator

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "wireguard-operator"
#Namespace: #Name

// renovate: datasource=github-releases depName=jodevsa/wireguard-operator extractVersion=^v(?<version>.*)$
#Version: "2.7.0"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    string | *#Name
				"app.kubernetes.io/version": #Version
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
	#NamespaceList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#VMServiceScrapeList.items,
]
