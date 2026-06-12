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
	metadata: {
		name: "vmsingle-vm"
		labels: {
			"app.kubernetes.io/component": "monitoring"
			"app.kubernetes.io/instance":  "vm"
			"app.kubernetes.io/name":      "vmsingle"
			"managed-by":                  "vm-operator"
		}
	}
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		storageClassName: "rook-ceph-nvme"
		resources: requests: (v1.#ResourceStorage): "96Gi"
		volumeName: "vm-vmsingle-vm"
	}
}, {
	metadata: {
		name: "vmalertmanager-vm-db-vmalertmanager-vm-0"
		labels: {
			"app.kubernetes.io/component": "monitoring"
			"app.kubernetes.io/instance":  "vm"
			"app.kubernetes.io/name":      "vmalertmanager"
			"managed-by":                  "vm-operator"
		}
	}
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		storageClassName: "rook-ceph-nvme"
		resources: requests: (v1.#ResourceStorage): "512Mi"
		volumeName: "vm-vmalertmanager-vm-db-vmalertmanager-vm-0"
	}
}]
