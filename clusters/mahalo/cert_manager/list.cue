package cert_manager

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: string | *"cert-manager"
	}]
}

items: namespace +
	service_account +
	custom_resource_definition +
	cluster_role +
	cluster_role_binding +
	role +
	role_binding +
	service +
	deployment +
	validating_webhook_configuration +
	mutating_webhook_configuration
