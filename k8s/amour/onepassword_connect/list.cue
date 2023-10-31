package onepassword_connect

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "onepassword-connect"
#Namespace: #Name
#Version:   "1.7.2"

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

#List: items: list.Concat(_items)

_items: [
	#CiliumNetworkPolicyList.items,
	#DeploymentList.items,
	#NamespaceList.items,
	#SecretList.items,
	#ServiceList.items,
]
