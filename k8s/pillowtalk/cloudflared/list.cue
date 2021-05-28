package cloudflared

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"cloudflared"
			namespace: "cloudflared"
			labels: {
				"app.kubernetes.io/name":      "cloudflared"
				"app.kubernetes.io/instance":  "cloudflared"
				"app.kubernetes.io/version":   "2021.5.10"
				"app.kubernetes.io/component": "cloudflared"
			}
		}
	}]

}

list: items:
	namespaceList.items +
	sealedSecretList.items +
	configMapList.items +
	deploymentList.items
