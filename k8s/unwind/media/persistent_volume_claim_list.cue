package media

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
	metadata: name: "\(#Name)-books"
	spec: {
		accessModes: [v1.#ReadWriteMany]
		storageClassName: "rook-cephfs-hdd-ec-retain"
		resources: requests: storage: "32Gi"
	}
}, {
	metadata: name: "\(#Name)-downloads"
	spec: {
		accessModes: [v1.#ReadWriteMany]
		storageClassName: "rook-cephfs-hdd-ec-retain"
		resources: requests: storage: "500Gi"
	}
}, {
	metadata: name: "\(#Name)-movies"
	spec: {
		accessModes: [v1.#ReadWriteMany]
		storageClassName: "rook-cephfs-hdd-ec-retain"
		resources: requests: storage: "3Ti"
	}
}, {
	metadata: name: "\(#Name)-music"
	spec: {
		accessModes: [v1.#ReadWriteMany]
		storageClassName: "rook-cephfs-hdd-ec-retain"
		resources: requests: storage: "128Gi"
	}
}, {
	metadata: name: "\(#Name)-shows"
	spec: {
		accessModes: [v1.#ReadWriteMany]
		storageClassName: "rook-cephfs-hdd-ec-retain"
		resources: requests: storage: "5Ti"
	}
}]
