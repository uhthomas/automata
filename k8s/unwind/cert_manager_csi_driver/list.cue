package cert_manager_csi_driver

import "k8s.io/api/core/v1"

#Name:      "cert-manager-csi-driver"
#Namespace: #Name
#Version:   "0.5.0"

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
	#ClusterRoleBindingList.items +
	#ClusterRoleList.items +
	#CSIDriverList.items +
	#DaemonSetList.items +
	#ServiceAccountList.items
