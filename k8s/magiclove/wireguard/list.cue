package wireguard

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "wireguard"
#Namespace: #Name

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			namespace: #Namespace
			labels: "app.kubernetes.io/name": #Name
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#NamespaceList.items,
	#WireguardList.items,
	#WireguardPeerList.items,
	#VMServiceScrapeList.items,
]
