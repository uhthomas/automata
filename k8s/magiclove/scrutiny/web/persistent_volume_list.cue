package web

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
	metadata: name: "scrutiny-data-scrutiny-web-0"
	spec: {
		capacity: storage: "1Gi"
		csi: {
			driver:       "rook-ceph.rbd.csi.ceph.com"
			volumeHandle: "csi-vol-ddc0f5c1-4589-4e8e-afbe-5c4d75a2bd46"
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
