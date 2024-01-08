package smartctl_exporter

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "smartctl-exporter"
#Namespace: #Name

// renovate: datasource=github-tags depName=prometheus-community/smartctl_exporter extractVersion=^v(?<version>.*)$
#Version: "0.11.0"

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
	#DaemonSetList.items,
	#NamespaceList.items,
	#ServiceList.items,
	#VMRuleList.items,
	#VMServiceScrapeList.items,
]
