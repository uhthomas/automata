package legacybackup

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
	metadata: name: #Name
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		storageClassName: "rook-ceph-hdd-ec-retain-block"
		resources: requests: storage: "16Ti"
	}
}, {
	metadata: name: "\(#Name)-legacy"
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		storageClassName: "local-storage"
		resources: requests: storage: "16Ti"
	}
}]
