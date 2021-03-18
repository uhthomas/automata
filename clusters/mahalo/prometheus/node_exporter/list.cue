package node_exporter

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items:
		service_account +
		role +
		role_binding +
		daemon_set
}
