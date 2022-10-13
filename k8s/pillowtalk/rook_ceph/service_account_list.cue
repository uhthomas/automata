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
	{
		metadata: {
			name: "rook-ceph-cmd-reporter"
			labels: {
				operator:                    "rook"
				"storage-backend":           "ceph"
				"app.kubernetes.io/part-of": "rook-ceph-operator"
			}
		}
	}, {
		metadata: {
			name: "rook-ceph-mgr"
			labels: {
				operator:                    "rook"
				"storage-backend":           "ceph"
				"app.kubernetes.io/part-of": "rook-ceph-operator"
			}
		}
	}, {
		metadata: {
			name: "rook-ceph-osd"
			labels: {
				operator:                    "rook"
				"storage-backend":           "ceph"
				"app.kubernetes.io/part-of": "rook-ceph-operator"
			}
		}
	},  {
		metadata: {
			name: "rook-ceph-rgw"
			labels: {
				operator:                    "rook"
				"storage-backend":           "ceph"
				"app.kubernetes.io/part-of": "rook-ceph-operator"
			}
		}
	}, {
		metadata: {
			name: "rook-ceph-system"
			labels: {
				operator:                    "rook"
				"storage-backend":           "ceph"
				"app.kubernetes.io/part-of": "rook-ceph-operator"
			}
		}
	},
	{metadata: name: "rook-ceph-purge-osd"},
	{metadata: name: "rook-csi-cephfs-plugin-sa"},
	{metadata: name: "rook-csi-cephfs-provisioner-sa"},
	{metadata: name: "rook-csi-rbd-plugin-sa"},
	{metadata: name: "rook-csi-rbd-provisioner-sa"},
]
