package typesense

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "typesense"
#Version: "0.24.1"

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
	#SecretProviderClassList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
