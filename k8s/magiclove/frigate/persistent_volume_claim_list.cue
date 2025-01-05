package frigate

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
	metadata: name: "config-dir-frigate-0"
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		storageClassName: "rook-ceph-nvme"
		resources: requests: (v1.#ResourceStorage): "1Gi"
		volumeName: "frigate-config-dir-frigate-0"
	}
}, {
	metadata: name: "media-frigate-0"
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		storageClassName: "rook-ceph-nvme"
		resources: requests: (v1.#ResourceStorage): "1Ti"
		volumeName: "frigate-media-frigate-0"
	}
}]
