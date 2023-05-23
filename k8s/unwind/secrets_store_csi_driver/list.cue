package secrets_store_csi_driver

import (
	"list"

	"k8s.io/api/core/v1"
)

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

#List: items: list.Concat(_items)

_items: [
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#CSIDriverList.items,
	#CustomResourceDefinitionList.items,
	#DaemonSetList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
]
