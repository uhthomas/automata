package prometheus

import corev1 "k8s.io/api/core/v1"

service: corev1.#Service & {
	apiVersion: "v1"
	kind:       "Service"
	metadata: name: "server"
	spec: {
		ports: [{
			name: "http"
			port: 80
			targetPort: "http"
		}, {
			name:       "grpc"
			port:       50051
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/component": "server"
		}
	}
}
