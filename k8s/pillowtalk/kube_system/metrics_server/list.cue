package metrics_server

import corev1 "k8s.io/api/core/v1"

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items:      deployment +
		service +
		api_service +
		role_binding +
		cluster_role +
		cluster_role_binding
}
