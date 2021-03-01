package query

import corev1 "k8s.io/api/core/v1"

service: corev1.#Service & {
	apiVersion: "v1"
	kind:       "Service"
	metadata: name: "query"
	spec: {
		ports: [{
			name:       "grpc"
			port:       50051
			targetPort: "grpc"
		}, {
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: app: "query"
	}
}
