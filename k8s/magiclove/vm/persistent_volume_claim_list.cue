package vm

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
	metadata: name: "vmsingle-vm"
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		storageClassName: "rook-ceph-nvme"
		resources: requests: (v1.#ResourceStorage): "64Gi"
		volumeName: "vm-vmsingle-vm"
	}
}, {
	metadata: name: "vmalertmanager-vm-db-vmalertmanager-vm-0"
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		storageClassName: "rook-ceph-nvme"
		resources: requests: (v1.#ResourceStorage): "512Mi"
		volumeName: "vm-vmalertmanager-vm-db-vmalertmanager-vm-0"
	}
}]
