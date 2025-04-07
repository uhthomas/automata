package sana

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "sana"
#Namespace: "backup"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: name: string | *#Name}]
}

#List: items: list.Concat(_items)

_items: [#PersistentVolumeClaimList.items]
