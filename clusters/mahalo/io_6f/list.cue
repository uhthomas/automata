package io_6f

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "io-6f"
	}]
}

items: namespace +
	service +
	deployment +
	horizontal_pod_autoscaler +
	ingress
