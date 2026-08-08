package recyclarr

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name: "recyclarr"

// renovate: datasource=docker depName=ghcr.io/recyclarr/recyclarr
#Version: "8.7.0"

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
	#PersistentVolumeClaimList.items,
	#ConfigMapList.items,
	#CronJobList.items,
	#ExternalSecretList.items,
]
