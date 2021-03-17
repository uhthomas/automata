package server

import "k8s.io/api/core/v1"

persistent_volume_claim: [...v1.#PersistentVolumeClaim]

persistent_volume_claim: [{
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		name: "server"
		labels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/version":   "2.25.1"
			"app.kubernetes.io/component": "server"
		}
	}
	spec: {
		accessModes: [v1.#ReadWriteOnce]
		resources: requests: storage: "4Gi"
	}
}]
