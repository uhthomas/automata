package immich_server

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "immich-server"
#Namespace: "immich"

#Version:   "1.63.2"
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
	#SecretProviderClassList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
]
