package mosquitto

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "mosquitto"
#Namespace: #Name

// renovate: datasource=docker depName=eclipse-mosquitto
#Version: "2.0.20"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    string | *#Name
				"app.kubernetes.io/version": string | *#Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ConfigMapList.items,
	#NamespaceList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
