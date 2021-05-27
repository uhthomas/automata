package metrics_server

import corev1 "k8s.io/api/core/v1"

service_account: [...corev1.#ServiceAccount]

service_account: [{
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: name: "metrics-server"
}]
