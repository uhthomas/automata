package fluent_bit

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "fluent-bit"
#Namespace: #Name

// renovate: datasource=github-releases depName=fluent/fluent-bit
#Version: "4.2.2"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      #Name
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
