package kipp

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
			"app.kubernetes.io/name":      "kipp"
			"app.kubernetes.io/instance":  "kipp"
			"app.kubernetes.io/component": "kipp"
		}
	}
}]
