package kubevirt

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "kubevirt-operator"
#Namespace: "kubevirt"
#Version:   "0.59.0"

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
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#KubeVirtList.items,
	#NamespaceList.items,
	#PriorityClassList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
]
