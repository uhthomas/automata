package synology

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
	metadata: name: "backup-synology"
	spec: {
		capacity: storage: "12Ti"
		csi: {
			driver:       "rook-ceph.rbd.csi.ceph.com"
			volumeHandle: "csi-vol-7cecf121-3059-4556-bddf-a5aabb3e40de-migrated"
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
		storageClassName:              "rook-ceph-nvme-ec"
		volumeMode:                    v1.#PersistentVolumeFilesystem
	}
}]
