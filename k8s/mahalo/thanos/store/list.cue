package store

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: "store"
			labels: "app.kubernetes.io/component": "store"
		}
	}]
}

list: items:
	serviceList.items +
	deploymentList.items +
	horizontalPodAutoscalerList.items
