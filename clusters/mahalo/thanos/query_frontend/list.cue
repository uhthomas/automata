package query_frontend

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: "query-frontend"
			labels: "app.kubernetes.io/component": "query-frontend"
		}
	}]
}

list: items:
	serviceList.items +
	deploymentList.items +
	horizontalPodAutoscalerList.items +
	ingressList.items
