package rook_ceph

import "k8s.io/api/core/v1"

serviceAccountList: v1.#ServiceAccountList & {
	apiVersion: "v1"
	kind:       "ServiceAccountList"
	items: [...{
		apiVersion: "v1"
		kind:       "ServiceAccount"
	}]
}

serviceAccountList: items: [
	{metadata: name: "rook-ceph-admission-controller"},
	// The rook system service account used by the operator, agent, and discovery pods
	{
		metadata: {
			name: "rook-ceph-system"
			labels: {
				operator:          "rook"
				"storage-backend": "ceph"
			}
		}
	},
	// Service account for the Ceph OSDs. Must exist and cannot be renamed.
	{metadata: name: "rook-ceph-osd"},
	// Service account for the Ceph Mgr. Must exist and cannot be renamed.
	{metadata: name: "rook-ceph-mgr"},
	{metadata: name: "rook-ceph-cmd-reporter"},
	{metadata: name: "rook-csi-cephfs-plugin-sa"},
	{metadata: name: "rook-csi-cephfs-provisioner-sa"},
	{metadata: name: "rook-csi-rbd-plugin-sa"},
	{metadata: name: "rook-csi-rbd-provisioner-sa"},
]
