package kipp2

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"kipp2"
			namespace: "kipp2"
			labels: {
				"app.kubernetes.io/name":      "kipp2"
				"app.kubernetes.io/instance":  "kipp2"
				"app.kubernetes.io/version":   "0.2.1"
				"app.kubernetes.io/component": "kipp2"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	sealedSecretList.items +
	serviceList.items +
	deploymentList.items +
	horizontalPodAutoscalerList.items +
	ingressList.items
