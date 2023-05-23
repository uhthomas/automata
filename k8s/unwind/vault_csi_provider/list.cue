package vault_csi_provider

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "vault-csi-provider"
#Namespace: #Name
#Version:   "1.2.1"
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
			name:      #Name
			namespace: #Namespace
			labels:    #Labels
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#DaemonSetList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
]
