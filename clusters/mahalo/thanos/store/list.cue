package store

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: "store"
			labels: "app.kubernetes.io/component": "store"
		}
	}]
}

items:
	serviceList.items +
	deploymentList.items +
	horizontalPodAutoscalerList.items
