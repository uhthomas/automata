package ping_exporter

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "ping-exporter"
#Namespace: #Name

// renovate: datasource=github-releases depName=czerwonk/ping_exporter
#Version: "v1.1.5"

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
	#DeploymentList.items,
	#NamespaceList.items,
	#ServiceList.items,
	#VMServiceScrapeList.items,
]
