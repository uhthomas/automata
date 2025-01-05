package fstrim

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "fstrim"
#Namespace: #Name

#Version: "2024.11.1"

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
	#CronJobList.items,
	#NamespaceList.items,
]
