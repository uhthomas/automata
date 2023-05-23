package transmission

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "transmission"
#Version: "4.0.2"

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
	#DeploymentList.items,
	#ServiceList.items,
	#PersistentVolumeClaimList.items,
]
