package ingress_nginx

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "ingress-nginx"
	}]
}

items: namespace +
	config_map +
	service_account +
	cluster_role +
	cluster_role_binding +
	role +
	role_binding +
	service +
	deployment +
	job +
	validating_webhook_configuration
