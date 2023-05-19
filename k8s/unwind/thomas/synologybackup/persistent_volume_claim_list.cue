package synologybackup

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
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		storageClassName: "rook-ceph-hdd-ec-retain-block"
		resources: requests: storage: "12Ti"
	}
}]
