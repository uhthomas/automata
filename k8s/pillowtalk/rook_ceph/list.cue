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
				"app.kubernetes.io/version":   "1.6.3"
				"app.kubernetes.io/component": "rook-ceph"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	podSecurityPolicyList.items +
	serviceAccountList.items +
	configMapList.items +
	customResourceDefinitionList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items +
	roleList.items +
	roleBindingList.items +
	deploymentList.items +

	// CRDs
	cephClusterList.items
