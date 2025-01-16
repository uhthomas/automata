package server

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "spire-server"
#Namespace: "spire"

// renovate: datasource=github-releases depName=spiffe/spire extractVersion=^v(?<version>.*)$
#Version: "1.5.1"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: #Name
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
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
