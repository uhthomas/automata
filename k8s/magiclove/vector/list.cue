package vector

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "vector"
#Namespace: #Name

// renovate: datasource=github-releases depName=vectordotdev/vector extractVersion=^v(?<version>.*)$
#Version: "0.53.0"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#ConfigMapList.items,
	#DaemonSetList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#VMServiceScrapeList.items,
]
