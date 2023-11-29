package prowlarr

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "prowlarr"
#Namespace: "media"
#Version:   "1.10.5.4116"

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
