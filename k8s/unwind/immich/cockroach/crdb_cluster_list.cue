package cockroach

import "k8s.io/api/core/v1"

#CrdbClusterList: v1.#List & {
	apiVersion: "crdb.cockroachlabs.com/v1alpha1"
	kind:       "CrdbClusterList"
	items: [...{
		apiVersion: "crdb.cockroachlabs.com/v1alpha1"
		kind:       "CrdbCluster"
	}]
}

#CrdbClusterList: items: [{
	spec: {
		dataStore: pvc: spec: {
			accessModes: [v1.#ReadWriteOnce]
			storageClassName: "rook-ceph-hdd-ec-delete-block"
			resources: requests: storage: "16Gi"
			volumeMode: v1.#PersistentVolumeFilesystem
		}
		resources: {
			requests: {
				cpu:    "1"
				memory: "2Gi"
			}
			limits: requests
		}
		tlsEnabled:         true
		cockroachDBVersion: "v22.2.2"
		nodes:              3
	}
}]
