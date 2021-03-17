package server

import "k8s.io/api/core/v1"

service_account: [...v1.#ServiceAccount]

service_account: [{
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name: "server"
		labels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/version":   "2.25.1"
			"app.kubernetes.io/component": "server"
		}
	}
}]
