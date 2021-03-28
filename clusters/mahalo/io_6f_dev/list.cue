package io_6f_dev

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "io-6f-dev"
			namespace: "io-6f-dev"
			labels: {
				"app.kubernetes.io/name":      "io-6f-dev"
				"app.kubernetes.io/instance":  "io-6f-dev"
				"app.kubernetes.io/version":   "1.4.0"
				"app.kubernetes.io/component": "io-6f-dev"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	serviceList.items +
	deploymentList.items +
	horizontalPodAutoscalerList.items +
	ingressList.items
