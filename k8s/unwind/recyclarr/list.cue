package recyclarr

import "k8s.io/api/core/v1"

#Name:      "recyclarr"
#Namespace: #Name
#Version:   "4.3.0"

// TODO: Provision secrets.
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
	#ConfigMapList.items +
	#CronJobList.items
