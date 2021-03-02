package prometheus

import corev1 "k8s.io/api/core/v1"

service: corev1.#Service & {
	apiVersion: "v1"
	kind:       "Service"
	metadata: name: "thanos"
	spec: {
		ports: [{
			name:       "grpc"
			port:       50051
			targetPort: "thanos-grpc"
		}]
		selector: app: "prometheus"
	}
}
