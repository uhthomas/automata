package bazarr

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "bazarr"
#Version: "1.2.0"

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
	#PersistentVolumeClaimList.items,
	#ServiceList.items,
]
