package rook_ceph

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "rook-ceph"
#Namespace: #Name
#Version:   "1.12.7"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":      string | *#Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/version":   #Version
				"app.kubernetes.io/component": string | *#Name
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#CephBlockPoolList.items,
	#CephClusterList.items,
	#CephFilesystemList.items,
	#CephObjectStoreList.items,
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#ConfigMapList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#IngressList.items,
	#NamespaceList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#StorageClassList.items,
	#VMServiceScrapeList.items,
]
