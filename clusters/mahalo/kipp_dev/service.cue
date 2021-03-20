package kipp_dev

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
			"app.kubernetes.io/name":      "kipp-dev"
			"app.kubernetes.io/instance":  "kipp-dev"
			"app.kubernetes.io/component": "kipp-dev"
		}
	}
}]
