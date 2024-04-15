package victoria_logs

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "victoria-logs"
#Namespace: #Name

// renovate: datasource=docker depName=victoriametrics/victoria-logs versioning=docker extractVersion=^v(?<version>.*)$
#Version: "0.5.2-victorialogs"

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
	#NamespaceList.items,
	#ServiceList.items,
	#StatefulSetList.items,
	#VMServiceScrapeList.items,
]
