package tdarr

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "tdarr"
#Version: "dev_2.00.21_2023_04_08T16_19_10z"

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
