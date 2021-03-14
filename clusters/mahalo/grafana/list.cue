package grafana

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "grafana"
	}]
}

items: namespace +
	sealed_secret +
	config_map +
	service +
	deployment +
	horizontal_pod_autoscaler +
	ingress
