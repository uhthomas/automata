package kipp_dev

import corev1 "k8s.io/api/core/v1"

service: corev1.#Service & {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name:      "kipp"
		namespace: "kipp-dev"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: app: "kipp"
	}
}
