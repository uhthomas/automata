package bazarr

import "k8s.io/api/core/v1"

#Name:      "bazarr"
#Namespace: #Name
#Version:   "1.2.0"

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
