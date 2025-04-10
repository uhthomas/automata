package emqx_exporter

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "emqx-exporter"
#Namespace: #Name

// renovate: datasource=github-releases depName=emqx/emqx-exporter
#Version: "0.2.11"

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
	#ExternalSecretList.items,
	#DeploymentList.items,
	#NamespaceList.items,
	#ServiceList.items,
	#VMServiceScrapeList.items,
]
