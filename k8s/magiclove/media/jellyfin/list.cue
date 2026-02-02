package jellyfin

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name: "jellyfin"

// renovate: datasource=github-releases depName=jellyfin/jellyfin extractVersion=^v(?<version>.*)$
#Version: "10.11.6"

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
	#GatewayList.items,
	#HTTPRouteList.items,
	#PersistentVolumeClaimList.items,
	#PersistentVolumeList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
