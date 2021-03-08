package promtail

import corev1 "k8s.io/api/core/v1"

corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "promtail"
	}]
}

items: namespace +
	service_account +
	cluster_role +
	cluster_role_binding +
	config_map +
	daemon_set
