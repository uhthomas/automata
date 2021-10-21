package kipp

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"kipp"
			namespace: "kipp"
			labels: {
				"app.kubernetes.io/name":      "kipp"
				"app.kubernetes.io/instance":  "kipp"
				"app.kubernetes.io/version":   "0.2.1"
				"app.kubernetes.io/component": "kipp"
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
