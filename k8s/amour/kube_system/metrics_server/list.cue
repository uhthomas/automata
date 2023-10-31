package metrics_server

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "metrics-server"
#Namespace: "kube-system"
#Version:   "0.6.3"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: string | *#Name
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#APIServiceList.items,
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#DeploymentList.items,
	#RoleBindingList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
]
