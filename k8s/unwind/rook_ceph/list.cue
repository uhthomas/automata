package rook_ceph

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"rook-ceph"
			namespace: "rook-ceph"
			labels: {
				"app.kubernetes.io/name":      "rook-ceph"
				"app.kubernetes.io/instance":  "rook-ceph"
				"app.kubernetes.io/version":   "1.10.11"
				"app.kubernetes.io/component": string | *"rook-ceph"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	clusterRoleBindingList.items +
	clusterRoleList.items +
	configMapList.items +
	customResourceDefinitionList.items +
	deploymentList.items +
	roleBindingList.items +
	roleList.items +
	serviceAccountList.items +
	serviceList.items +
	storageClassList.items +

	// CRDs.
	cephClusterList.items +
	cephBlockPoolList.items
// cephObjectStoreList.items +
// objectBucketClaimList.items
