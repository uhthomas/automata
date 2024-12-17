package immich_machine_learning

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "immich-machine-learning"
#Component: "machine-learning"

// renovate: datasource=github-releases depName=immich-app/immich extractVersion=^v(?<version>.*)$
#Version: "1.123.0"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: string | *#Name
			labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/version":   #Version
				"app.kubernetes.io/component": #Component
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#DeploymentList.items,
	#PersistentVolumeClaimList.items,
	#ServiceList.items,
]
