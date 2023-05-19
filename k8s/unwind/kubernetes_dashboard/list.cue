package kubernetes_dashboard

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "kubernetes-dashboard"
#Namespace: #Name
#Version:   "2.7.0"

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
	#DeploymentList.items,
	#NamespaceList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#SecretList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
]
