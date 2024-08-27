package synology

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "synology"
#Namespace: "backup"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: name: string | *#Name}]
}

#List: items: list.Concat(_items)

_items: [
	#IngressList.items,
	#DeploymentList.items,
	#PersistentVolumeClaimList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
