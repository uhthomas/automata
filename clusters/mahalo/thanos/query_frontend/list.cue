package query_frontend

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: "query-frontend"
			labels: "app.kubernetes.io/component": "query-frontend"
		}
	}]
}

items:
	service +
	deployment +
	horizontal_pod_autoscaler +
	ingress
