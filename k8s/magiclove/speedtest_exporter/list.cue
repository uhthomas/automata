package speedtest_exporter

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "speedtest-exporter"
#Namespace: #Name

// renovate: datasource=github-releases depName=MiguelNdeCarvalho/speedtest-exporter extractVersion=^v(?<version>.*)$
#Version: "3.5.4"

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
	#DeploymentList.items,
	#NamespaceList.items,
	#ServiceList.items,
	#VMServiceScrapeList.items,
]
