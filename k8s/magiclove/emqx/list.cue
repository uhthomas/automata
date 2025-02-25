package emqx

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "emqx"
#Namespace: #Name

// renovate: datasource=github-releases depName=emqx/emqx extractVersion=^v(?<version>.*)$
#Version: "5.8.5"

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
	#CertificateList.items,
	#GatewayList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#PersistentVolumeClaimList.items,
	#PersistentVolumeList.items,
	#ServiceList.items,
	#StatefulSetList.items,
	#VMServiceScrapeList.items,
]
