package rasmus

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"rasmus"
			namespace: "rasmus"
			labels: {
				"app.kubernetes.io/name":      "rasmus"
				"app.kubernetes.io/instance":  "rasmus"
				"app.kubernetes.io/version":   "0.2.15"
				"app.kubernetes.io/component": "rasmus"
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
