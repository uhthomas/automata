package compact

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: "compact"
			labels: "app.kubernetes.io/component": "compact"
		}
	}]
}

list: items:
	persistentVolumeClaimList.items +
	deploymentList.items
