package immich_server

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "immich-server"
#Version:   "1.53.0"
#Component: "server"

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
