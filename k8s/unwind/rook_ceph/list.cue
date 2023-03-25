package rook_ceph

import "k8s.io/api/core/v1"

#Name:      "rook-ceph"
#Namespace: #Name
#Version:   "1.11.0"

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

#List: items:
	#NamespaceList.items +
	#ClusterRoleBindingList.items +
	#ClusterRoleList.items +
	#ConfigMapList.items +
	#CustomResourceDefinitionList.items +
	#DeploymentList.items +
	#RoleBindingList.items +
	#RoleList.items +
	#ServiceAccountList.items +
	#ServiceList.items +
	#StorageClassList.items +

	// CRDs.
	#CephClusterList.items +
	#CephBlockPoolList.items
// #CephObjectStoreList.items +
// #ObjectBucketClaimList.items
