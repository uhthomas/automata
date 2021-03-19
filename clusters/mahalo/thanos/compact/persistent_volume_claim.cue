package compact

import "k8s.io/api/core/v1"

persistent_volume_claim: [...v1.#PersistentVolumeClaim]

persistent_volume_claim: [{
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		resources: requests: storage: "30Gi"
	}
}]
