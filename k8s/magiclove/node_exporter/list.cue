package node_exporter

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "node-exporter"
#Namespace: #Name
#Version:   "1.6.0"

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
	#NamespaceList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#VMRuleList.items,
	#VMServiceScrapeList.items,
]
