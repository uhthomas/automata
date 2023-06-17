package legacybackup

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "legacybackup"
#Namespace: "thomas"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

#List: items: list.Concat(_items)

_items: [#PersistentVolumeClaimList.items]
