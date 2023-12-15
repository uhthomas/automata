package master

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "node-feature-discovery-master"
#Namespace: "node-feature-discovery"
#Version:   "0.14.3"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      #Name
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
	#DeploymentList.items,
	#ServiceAccountList.items,
]
