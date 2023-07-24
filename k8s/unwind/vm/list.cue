package vm

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "vm"
#Namespace: #Name

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: "app.kubernetes.io/name": #Name
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#NamespaceList.items,
	#VMAgentList.items,
	#VMAlertList.items,
	#VMAlertmanagerList.items,
	#VMClusterList.items,
	#VMNodeScrapeList.items,
	#VMRuleList.items,
]
