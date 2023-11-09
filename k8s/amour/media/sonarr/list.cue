package sonarr

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "sonarr"
#Version: "develop-4.0.0.710-ls4"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: string | *#Name
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#IngressList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
