package io_6f

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "io-6f"
			namespace: "io-6f"
			labels: {
				"app.kubernetes.io/name":      "io-6f"
				"app.kubernetes.io/instance":  "io-6f"
				"app.kubernetes.io/version":   "1.4.1"
				"app.kubernetes.io/component": "io-6f"
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
