package secrets_store_csi_driver

import "k8s.io/api/core/v1"

#Name:      "secrets-store-csi-driver"
#Namespace: #Name
#Version:   "1.3.2"
#Labels: {
	"app.kubernetes.io/name":    #Name
	"app.kubernetes.io/version": #Version
	...
}

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels:    #Labels
		}
	}]

}

#List: items:
	// The namespace must be created first.
	#NamespaceList.items +
	// Lexicographic ordering.
	#ClusterRoleBindingList.items +
	#ClusterRoleList.items +
	#CSIDriverList.items +
	#CustomResourceDefinitionList.items +
	#DaemonSetList.items +
	#ServiceAccountList.items
