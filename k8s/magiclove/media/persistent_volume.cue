package media

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
	metadata: name: "media-media"
	spec: {
		capacity: storage: "8Ti"
		csi: {
			driver:       "rook-ceph.cephfs.csi.ceph.com"
			volumeHandle: "media-media"
			controllerExpandSecretRef: {
				name:      "rook-csi-cephfs-provisioner"
				namespace: "rook-ceph"
			}
			volumeAttributes: {
				clusterID:    "rook-ceph"
				fsName:       "main"
				rootPath:     "/volumes/csi/csi-vol-95d94b9d-e3f7-4b95-bd79-6005576ee3c1/45c65a90-bd64-46d9-aaf0-80d229aeb994"
				staticVolume: "true"
			}
			nodeStageSecretRef: {
				name:      "rook-csi-cephfs-node-user"
				namespace: "rook-ceph"
			}
		}
		accessModes: [v1.#ReadWriteMany]
		persistentVolumeReclaimPolicy: v1.#PersistentVolumeReclaimRetain
		storageClassName:              "rook-cephfs-nvme"
		volumeMode:                    v1.#PersistentVolumeFilesystem
	}
}]
