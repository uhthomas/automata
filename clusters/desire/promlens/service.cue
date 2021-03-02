package promlens

import corev1 "k8s.io/api/core/v1"

service: corev1.#Service & {
	apiVersion: "v1"
	kind:       "Service"
	metadata: name: "promlens"
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: app: "promlens"
	}
}
