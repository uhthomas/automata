package tdarr

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "tdarr"
#Version: "2.00.20.1"

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
	#ServiceList.items,
	#StatefulSetList.items,
]
