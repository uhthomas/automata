package metrics_server

import corev1 "k8s.io/api/core/v1"

service: [...corev1.#Service]

service: [{
	apiVersion: "v1"
	kind:       "Service"
	metadata: name: "metrics-server"
	spec: {
		ports: [{
			name:       "https"
			port:       443
			protocol:   "TCP"
			targetPort: "https"
		}]
		selector: app: "metrics-server"
	}
}]
