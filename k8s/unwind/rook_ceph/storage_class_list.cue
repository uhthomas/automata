package rook_ceph

import (
	"k8s.io/api/core/v1"
	storagev1 "k8s.io/api/storage/v1"
)

#StorageClassList: storagev1.#StorageClassList & {
	apiVersion: "v1"
	kind:       "StorageClassList"
	items: [...{
		apiVersion: "storage.k8s.io/v1"
		kind:       "StorageClass"
	}]
}

#StorageClassList: items: [{
	metadata: name: "rook-ceph-hdd-ec-delete-block"
	provisioner: "rook-ceph.rbd.csi.ceph.com"
	parameters: {
		clusterID:     "rook-ceph"
		dataPool:      "ecpool"
		pool:          "replicapool"
		imageFormat:   "2"
		imageFeatures: "layering"

		"csi.storage.k8s.io/provisioner-secret-name":            "rook-csi-rbd-provisioner"
		"csi.storage.k8s.io/provisioner-secret-namespace":       "rook-ceph"
		"csi.storage.k8s.io/controller-expand-secret-name":      "rook-csi-rbd-provisioner"
		"csi.storage.k8s.io/controller-expand-secret-namespace": "rook-ceph"
		"csi.storage.k8s.io/node-stage-secret-name":             "rook-csi-rbd-node"
		"csi.storage.k8s.io/node-stage-secret-namespace":        "rook-ceph"
		"csi.storage.k8s.io/fstype":                             "ext4"
	}
	allowVolumeExpansion: true
	reclaimPolicy:        v1.#PersistentVolumeReclaimDelete
}]
