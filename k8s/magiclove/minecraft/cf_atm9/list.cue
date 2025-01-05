package cf_atm9

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "minecraft-cf-atm9"
#Version: "2024.3.0"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: #Name
			labels: "app.kubernetes.io/name": #Name
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ExternalSecretList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
