package sabnzbd

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "sabnzbd"
#Version: "4.1.0"

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
