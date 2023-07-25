package grafana

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "grafana"
#Namespace: #Name

// renovate: datasource=github-releases depName=grafana/grafana extractVersion=^v(?<version>.*)$
#Version: "10.0.2"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      #Name
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
	#NamespaceList.items,
	#SecretProviderClassList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#StatefulSetList.items,
	#VMServiceScrapeList.items,
]
