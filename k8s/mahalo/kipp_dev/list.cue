package kipp_dev

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "kipp-dev"
			namespace: "kipp-dev"
			labels: {
				"app.kubernetes.io/name":      "kipp-dev"
				"app.kubernetes.io/instance":  "kipp-dev"
				"app.kubernetes.io/version":   "0.2.1"
				"app.kubernetes.io/component": "kipp-dev"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	networkPolicyList.items +
	sealedSecretList.items +
	serviceList.items +
	deploymentList.items +
	horizontalPodAutoscalerList.items +
	ingressList.items
