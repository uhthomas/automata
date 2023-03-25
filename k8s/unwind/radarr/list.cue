package radarr

import "k8s.io/api/core/v1"

#Name:      "radarr"
#Namespace: #Name
#Version:   "4.3.2"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]

}

#List: items:
	// The namespace must be created first.
	#NamespaceList.items +
	// Lexicographic ordering.
	#DeploymentList.items +
	#PersistentVolumeClaimList.items +
	#ServiceList.items
