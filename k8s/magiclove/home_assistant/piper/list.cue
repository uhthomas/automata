package piper

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name: "piper"

// renovate: datasource=docker depName=rhasspy/wyoming-piper
#Version: "1.6.3"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: #Name
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
