package compact

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: "compact"
			labels: "app.kubernetes.io/component": "compact"
		}
	}]
}

items: deployment
