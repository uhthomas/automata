package ingress_nginx

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: string | *"ingress-nginx"
	}]
}

items: namespace +
	service_account +
	config_map +
	cluster_role +
	cluster_role_binding +
	role +
	role_binding +
	service +
	deployment +
	job +
	validating_webhook_configuration
