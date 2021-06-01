package loki

import "k8s.io/api/core/v1"

persistentVolumeClaimList: v1.#PersistentVolumeClaimList & {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaimList"
	items: [...{
		apiVersion: "v1"
		kind:       "PersistentVolumeClaim"
	}]
}

persistentVolumeClaimList: items: [{
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		resources: requests: storage: "20Gi"
		storageClassName: "rook-ceph-replica-retain-block"
	}
}]
