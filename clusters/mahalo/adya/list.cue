package adya

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "adya"
			namespace: "adya"
			labels: {
				"app.kubernetes.io/name":      "adya"
				"app.kubernetes.io/instance":  "adya"
				"app.kubernetes.io/version":   "1.0.11"
				"app.kubernetes.io/component": "adya"
			}
		}
	}]
}

items:
	namespaceList.items +
	deploymentList.items +
	sealedSecretList.items
