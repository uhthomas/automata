package io_6f_dev

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: string | *"io-6f-dev"
	}]
}

items: namespace +
	service +
	deployment +
	horizontal_pod_autoscaler +
	ingress
