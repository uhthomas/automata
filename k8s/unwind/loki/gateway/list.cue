package gateway

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "loki-gateway"
#Component: "gateway"

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
	#ConfigMapList.items,
	#DeploymentList.items,
	#ServiceList.items,
]
