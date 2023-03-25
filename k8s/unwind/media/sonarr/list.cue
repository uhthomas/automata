package sonarr

import "k8s.io/api/core/v1"

#Name:    "sonarr"
#Version: "3.0.10"

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

#List: items:
	#DeploymentList.items +
	#PersistentVolumeClaimList.items +
	#ServiceList.items
