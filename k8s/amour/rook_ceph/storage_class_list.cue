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
	metadata: name: "rook-ceph-nvme"
	provisioner: "\(#Namespace).rbd.csi.ceph.com"
	parameters: {
		clusterID: #Namespace
		// dataPool:      "ecpool-nvme"
		pool:          "replicapool-nvme"
		imageFormat:   "2"
		imageFeatures: "layering,fast-diff,object-map,deep-flatten,exclusive-lock"

		"csi.storage.k8s.io/provisioner-secret-name":            "rook-csi-rbd-provisioner"
		"csi.storage.k8s.io/provisioner-secret-namespace":       #Namespace
		"csi.storage.k8s.io/controller-expand-secret-name":      "rook-csi-rbd-provisioner"
		"csi.storage.k8s.io/controller-expand-secret-namespace": #Namespace
		"csi.storage.k8s.io/node-stage-secret-name":             "rook-csi-rbd-node"
		"csi.storage.k8s.io/node-stage-secret-namespace":        #Namespace
		"csi.storage.k8s.io/fstype":                             "ext4"

		mounter: "rbd-nbd"
	}
	allowVolumeExpansion: true
	reclaimPolicy:        v1.#PersistentVolumeReclaimRetain
}, {
	metadata: name: "rook-ceph-hdd"
	provisioner: "\(#Namespace).rbd.csi.ceph.com"
	parameters: {
		clusterID:     #Namespace
		dataPool:      "ecpool-hdd"
		pool:          "replicapool-nvme"
		imageFormat:   "2"
		imageFeatures: "layering,fast-diff,object-map,deep-flatten,exclusive-lock"

		"csi.storage.k8s.io/provisioner-secret-name":            "rook-csi-rbd-provisioner"
		"csi.storage.k8s.io/provisioner-secret-namespace":       #Namespace
		"csi.storage.k8s.io/controller-expand-secret-name":      "rook-csi-rbd-provisioner"
		"csi.storage.k8s.io/controller-expand-secret-namespace": #Namespace
		"csi.storage.k8s.io/node-stage-secret-name":             "rook-csi-rbd-node"
		"csi.storage.k8s.io/node-stage-secret-namespace":        #Namespace
		"csi.storage.k8s.io/fstype":                             "ext4"

		mounter: "rbd-nbd"
	}
	allowVolumeExpansion: true
	reclaimPolicy:        v1.#PersistentVolumeReclaimRetain
}]
