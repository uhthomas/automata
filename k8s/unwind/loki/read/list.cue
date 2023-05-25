package read

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "loki-read"
#Component: "read"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: string | *#Name
			labels: "app.kubernetes.io/component": #Component
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#DeploymentList.items,
	#PodDisruptionBudgetList.items,
	#ServiceList.items,
]
