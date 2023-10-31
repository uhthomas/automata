package rook_ceph

import "k8s.io/api/core/v1"

#ServiceAccountList: v1.#ServiceAccountList & {
	apiVersion: "v1"
	kind:       "ServiceAccountList"
	items: [...{
		apiVersion: "v1"
		kind:       "ServiceAccount"
	}]
}

#ServiceAccountList: items: [{
	// Service account for the job that reports the Ceph version in an image
	metadata: {
		name: "rook-ceph-cmd-reporter"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
}, {
	// Service account for Ceph mgrs
	metadata: {
		name: "rook-ceph-mgr"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
}, {
	// Service account for Ceph OSDs
	metadata: {
		name: "rook-ceph-osd"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
}, {
	// Service account for job that purges OSDs from a Rook-Ceph cluster
	metadata: name: "rook-ceph-purge-osd"
}, {
	// Service account for RGW server
	metadata: {
		name: "rook-ceph-rgw"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
}, {
	// Service account for the Rook-Ceph operator
	metadata: {
		name: "rook-ceph-system"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
}, {
	metadata: {
		name: "objectstorage-provisioner"
		labels: {
			"app.kubernetes.io/name":      "cosi-driver-ceph"
			"app.kubernetes.io/component": "driver-ceph"
			"app.kubernetes.io/part-of":   "container-object-storage-interface"
		}
	}
}, {
	// Service account for the CephFS CSI driver
	metadata: name: "rook-csi-cephfs-plugin-sa"
}, {
	// Service account for the CephFS CSI provisioner
	metadata: name: "rook-csi-cephfs-provisioner-sa"
}, {
	// Service account for the RBD CSI driver
	metadata: name: "rook-csi-rbd-plugin-sa"
}, {
	// Service account for the RBD CSI provisioner
	metadata: name: "rook-csi-rbd-provisioner-sa"
}]
