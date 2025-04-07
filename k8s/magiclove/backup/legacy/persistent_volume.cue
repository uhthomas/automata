package legacy

import "k8s.io/api/core/v1"

#PersistentVolumeList: v1.#PersistentVolumeList & {
	apiVersion: "v1"
	kind:       "PersistentVolumeList"
	items: [...{
		apiVersion: "v1"
		kind:       "PersistentVolume"
	}]
}

#PersistentVolumeList: items: [{
	metadata: name: "backup-legacy"
	spec: {
		capacity: storage: "11Ti"
		csi: {
			driver:       "rook-ceph.rbd.csi.ceph.com"
			volumeHandle: "csi-vol-8ad117a4-9b27-4ace-88f3-ddc47b84aeb9"
			fsType:       "ext4"
			controllerExpandSecretRef: {
				name:      "rook-csi-rbd-provisioner"
				namespace: "rook-ceph"
			}
			volumeAttributes: {
				clusterID:     "rook-ceph"
				imageFeatures: "layering,fast-diff,object-map,deep-flatten,exclusive-lock"
				pool:          "replicapool-nvme"
				staticVolume:  "true"
			}
			nodeStageSecretRef: {
				name:      "rook-csi-rbd-node"
				namespace: "rook-ceph"
			}
		}
		accessModes: [v1.#ReadWriteOnce]
		persistentVolumeReclaimPolicy: v1.#PersistentVolumeReclaimRetain
		storageClassName:              "rook-ceph-hdd"
		volumeMode:                    v1.#PersistentVolumeFilesystem
	}
}]
