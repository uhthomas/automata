package jellyseerr

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "jellyseerr"
#Version: "2.0.1"

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
	#CertificateList.items,
	#GatewayList.items,
	#HTTPRouteList.items,
	#PersistentVolumeClaimList.items,
	#PersistentVolumeList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
