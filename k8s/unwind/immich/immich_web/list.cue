package immich_web

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "immich-web"
#Version:   "1.61.0"
#Component: "web"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: #Name
			labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/version":   #Version
				"app.kubernetes.io/component": #Component
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#DeploymentList.items,
	#ServiceList.items,
]
