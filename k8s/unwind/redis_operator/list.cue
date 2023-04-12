package redis_operator

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "redis-operator"
#Namespace: #Name
#Version:   "1.2.4"

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
	#NamespaceList.items,
	#PodMonitorList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
]
