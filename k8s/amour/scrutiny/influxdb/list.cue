package influxdb

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "scrutiny-influxdb"
#Namespace: "scrutiny"
#Version:   "2.7.4"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: #Name
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
	#ServiceList.items,
	#StatefulSetList.items,
]
