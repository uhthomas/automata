package immich_machine_learning

import "k8s.io/api/core/v1"

#PersistentVolumeClaimList: v1.#PersistentVolumeClaimList & {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaimList"
	items: [...{
		apiVersion: "v1"
		kind:       "PersistentVolumeClaim"
	}]
}

#PersistentVolumeClaimList: items: [{
	metadata: name: "\(#Name)-cache"
	spec: {
		accessModes: [v1.#ReadWriteMany]
		storageClassName: "rook-cephfs-hdd-ec-retain"
		resources: requests: storage: "32Gi"
	}
}]
