package collector

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "scrutiny-collector"
#Namespace: "scrutiny"
#Version:   "0.7.2"

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
	#DaemonSetList.items,
	#ServiceAccountList.items,
]
