package synologybackup

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name: "synologybackup"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

#List: items: list.Concat(_items)

_items: [
	#ConfigMapList.items,
	#JobList.items,
	#PersistentVolumeClaimList.items,
]
