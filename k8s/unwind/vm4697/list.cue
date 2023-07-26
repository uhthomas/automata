package vm4697

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "vm4697"
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
	#VMAgentList.items,
	#VMClusterList.items,
]
