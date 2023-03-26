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
	metadata: {
		name: "rook-ceph-hdd-ec-delete-block"
		annotations: "storageclass.kubernetes.io/is-default-class": "true"
	}
	provisioner: "\(#Namespace).rbd.csi.ceph.com"
	parameters: {
		clusterID:     #Namespace
		dataPool:      "ecpool"
		pool:          "replicapool"
		imageFormat:   "2"
		imageFeatures: "layering"

		"csi.storage.k8s.io/provisioner-secret-name":            "rook-csi-rbd-provisioner"
		"csi.storage.k8s.io/provisioner-secret-namespace":       #Namespace
		"csi.storage.k8s.io/controller-expand-secret-name":      "rook-csi-rbd-provisioner"
		"csi.storage.k8s.io/controller-expand-secret-namespace": #Namespace
		"csi.storage.k8s.io/node-stage-secret-name":             "rook-csi-rbd-node"
		"csi.storage.k8s.io/node-stage-secret-namespace":        #Namespace
		"csi.storage.k8s.io/fstype":                             "ext4"
	}
	allowVolumeExpansion: true
	reclaimPolicy:        v1.#PersistentVolumeReclaimDelete
}, {
	metadata: name: "rook-cephfs-hdd-ec-retain"
	provisioner: "\(#Namespace).cephfs.csi.ceph.com"
	parameters: {
		clusterID: #Namespace
		fsName:    "mainfs-ec"
		pool:      "mainfs-ec-erasurecoded"

		"csi.storage.k8s.io/provisioner-secret-name":            "rook-csi-cephfs-provisioner"
		"csi.storage.k8s.io/provisioner-secret-namespace":       #Namespace
		"csi.storage.k8s.io/controller-expand-secret-name":      "rook-csi-cephfs-provisioner"
		"csi.storage.k8s.io/controller-expand-secret-namespace": #Namespace
		"csi.storage.k8s.io/node-stage-secret-name":             "rook-csi-cephfs-node"
		"csi.storage.k8s.io/node-stage-secret-namespace":        #Namespace
	}
	allowVolumeExpansion: true
	reclaimPolicy:        v1.#PersistentVolumeReclaimRetain
}, {
	metadata: name: "rook-ceph-loki-bucket"
	provisioner: "rook-ceph.ceph.rook.io/bucket"
	parameters: {
		objectStoreName:      "ecstore-hdd"
		objectStoreNamespace: #Namespace
	}
}, {
	metadata: name: "rook-ceph-mimir-blocks-bucket"
	provisioner: "rook-ceph.ceph.rook.io/bucket"
	parameters: {
		objectStoreName:      "ecstore-hdd"
		objectStoreNamespace: #Namespace
	}
}, {
	metadata: name: "rook-ceph-mimir-ruler-bucket"
	provisioner: "rook-ceph.ceph.rook.io/bucket"
	parameters: {
		objectStoreName:      "ecstore-hdd"
		objectStoreNamespace: #Namespace
	}
}]
