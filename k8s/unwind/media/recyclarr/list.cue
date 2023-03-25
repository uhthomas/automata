package recyclarr

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "recyclarr"
#Version: "4.3.0"

// TODO: Provision secrets.
#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: string | *#Name
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]

}

#List: items: list.Concat(_items)

_items: [
	#ConfigMapList.items,
	#CronJobList.items,
]
