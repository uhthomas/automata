package io_6f

import "k8s.io/api/core/v1"

service: [...v1.#Service]

service: [{
	apiVersion: "v1"
	kind:       "Service"
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: {
			"app.kubernetes.io/name":      "io-6f"
			"app.kubernetes.io/instance":  "io-6f"
			"app.kubernetes.io/component": "io-6f"
		}
	}
}]
