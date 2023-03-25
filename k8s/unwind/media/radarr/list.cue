package radarr

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "radarr"
#Version: "4.3.2"

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
