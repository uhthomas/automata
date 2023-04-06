package olm

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "olm"
#Namespace: #Name

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/version":   "1.11.0"
				"app.kubernetes.io/component": string | *#Name
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: []

// #ClusterRoleBindingList.items,
// #ClusterRoleList.items,
// #ConfigMapList.items,
// #CustomResourceDefinitionList.items,
// #DeploymentList.items,
// #NamespaceList.items
// #RoleBindingList.items,
// #RoleList.items,
// #ServiceAccountList.items,
// #ServiceList.items,
// #StorageClassList.items,
