package frigate

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "frigate"
#Namespace: #Name

// renovate: datasource=github-releases depName=blakeblackshear/frigate extractVersion=^v(?<version>.*)$
#Version: "0.16.4"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ConfigMapList.items,
	#ExternalSecretList.items,
	#GatewayList.items,
	#HTTPRouteList.items,
	#PersistentVolumeClaimList.items,
	#PersistentVolumeList.items,
	#NamespaceList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
