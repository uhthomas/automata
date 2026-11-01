package server

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:    "immich-server"
#Version: "2.6.3"

#SambaImage: "ghcr.io/uhthomas/uhthomas/samba:bd3b035dfed35f2749892201f002331525c0af67"

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
	#DeploymentList.items,
	#ExternalSecretList.items,
	#PasswordList.items,
	#PersistentVolumeClaimList.items,
	#ServiceList.items,
	#SnapshotScheduleList.items,
	#VMServiceScrapeList.items,
]
