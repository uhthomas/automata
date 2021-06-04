package grafana

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "grafana"
			namespace: "grafana"
			labels: {
				"app.kubernetes.io/name":      "grafana"
				"app.kubernetes.io/instance":  "grafana"
				"app.kubernetes.io/version":   "7.5.2"
				"app.kubernetes.io/component": "grafana"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	sealedSecretList.items +
	configMapList.items +
	serviceList.items +
	deploymentList.items +
	// TODO(thomas): Use the new auto-scaling API.
	// TODO(thomas): Re-enable once it's clear what database it's going
	// to use.
	// horizontalPodAutoscalerList.items +
	ingressList.items
