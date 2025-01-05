package melonade

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "melonade"
#Namespace: "backup"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: name: string | *#Name}]
}

#List: items: list.Concat(_items)

_items: [
	#PersistentVolumeClaimList.items,
	#PersistentVolumeList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
