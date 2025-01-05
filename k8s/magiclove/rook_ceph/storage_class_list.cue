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

let defaultParameters = {
	"csi.storage.k8s.io/provisioner-secret-namespace":       #Namespace
	"csi.storage.k8s.io/controller-expand-secret-namespace": #Namespace
	"csi.storage.k8s.io/node-stage-secret-namespace":        #Namespace
}

let defaultRBDParameters = defaultParameters & {
	clusterID:     #Namespace
	imageFormat:   "2"
	imageFeatures: "layering,fast-diff,object-map,deep-flatten,exclusive-lock"
	mounter:       "rbd-nbd"

	"csi.storage.k8s.io/provisioner-secret-name":       "rook-csi-rbd-provisioner"
	"csi.storage.k8s.io/controller-expand-secret-name": "rook-csi-rbd-provisioner"
	"csi.storage.k8s.io/node-stage-secret-name":        "rook-csi-rbd-node"
	"csi.storage.k8s.io/fstype":                        "ext4"
}

let defaultCephFSParameters = defaultParameters & {
	clusterID: #Namespace

	"csi.storage.k8s.io/provisioner-secret-name":       "rook-csi-cephfs-provisioner"
	"csi.storage.k8s.io/controller-expand-secret-name": "rook-csi-cephfs-provisioner"
	"csi.storage.k8s.io/node-stage-secret-name":        "rook-csi-cephfs-node"
}

#StorageClassList: items: [{
	metadata: name: "rook-ceph-nvme"
	provisioner: "\(#Namespace).rbd.csi.ceph.com"
	parameters: defaultRBDParameters & {
		pool: "replicapool-nvme"
	}
	reclaimPolicy:        v1.#PersistentVolumeReclaimRetain
	allowVolumeExpansion: true
}, {
	metadata: name: "rook-ceph-nvme-ec"
	provisioner: "\(#Namespace).rbd.csi.ceph.com"
	parameters: defaultRBDParameters & {
		dataPool: "ecpool-nvme"
		pool:     "replicapool-nvme"
	}
	reclaimPolicy:        v1.#PersistentVolumeReclaimRetain
	allowVolumeExpansion: true
}, {
	metadata: name: "rook-ceph-hdd"
	provisioner: "\(#Namespace).rbd.csi.ceph.com"
	parameters: defaultRBDParameters & {
		dataPool: "ecpool-hdd"
		pool:     "replicapool-nvme"
	}
	reclaimPolicy:        v1.#PersistentVolumeReclaimRetain
	allowVolumeExpansion: true
}, {
	metadata: name: "rook-cephfs-nvme"
	provisioner: "\(#Namespace).cephfs.csi.ceph.com"
	parameters: defaultCephFSParameters & {
		fsName: "main"
		pool:   "main-nvme-ec"
	}
	reclaimPolicy:        v1.#PersistentVolumeReclaimRetain
	allowVolumeExpansion: true
}]
