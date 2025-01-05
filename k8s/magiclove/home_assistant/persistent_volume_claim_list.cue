package home_assistant

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
	metadata: name: "config-home-assistant-0"
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		storageClassName: "rook-ceph-nvme"
		resources: requests: (v1.#ResourceStorage): "2Gi"
		volumeName: "home-assistant-config-home-assistant-0"
	}
}]
