package breakfast

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "breakfast"
#Namespace: "backup"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

#List: items: list.Concat(_items)

_items: [
	#IngressList.items,
	#PersistentVolumeClaimList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
