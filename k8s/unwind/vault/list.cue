package vault

import "k8s.io/api/core/v1"

#Name:      "vault"
#Namespace: #Name
#Version:   "1.13.0"

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
	#ConfigMapList.items +
	#RoleBindingList.items +
	#RoleList.items +
	#ServiceAccountList.items +
	#ServiceList.items +
	#StatefulSetList.items
