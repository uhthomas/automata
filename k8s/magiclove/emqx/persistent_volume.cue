package emqx

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
	metadata: name: "emqx-data-emqx-0"
	spec: {
		capacity: storage: "64Mi"
		csi: {
			driver:       "rook-ceph.rbd.csi.ceph.com"
			volumeHandle: "csi-vol-a33f1dc8-6373-437f-b99e-6ce8eba4ddbb"
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
		storageClassName:              "rook-ceph-nvme"
		volumeMode:                    v1.#PersistentVolumeFilesystem
	}
}]
