package rook_ceph

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "rook-ceph"
#Namespace: #Name
#Version:   "1.11.2"

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
				"app.kubernetes.io/version":   #Version
				"app.kubernetes.io/component": string | *#Name
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	// The namespace must be created first.
	#NamespaceList.items,

	// Lexicographic ordering.
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#ConfigMapList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#StorageClassList.items,

	// CRDs.
	#CephBlockPoolList.items,
	#CephClusterList.items,
	#CephFilesystemList.items,
]

// #CephObjectStoreList.items,
// #ObjectBucketClaimList.items,
