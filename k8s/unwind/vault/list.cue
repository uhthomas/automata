package vault

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "vault"
#Namespace: #Name
#Version:   "1.13.0"

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
	#ConfigMapList.items,
	#NamespaceList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
