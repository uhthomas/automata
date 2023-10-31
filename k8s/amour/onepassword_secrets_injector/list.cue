package onepassword_secrets_injector

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "onepassword-secrets-injector"
#Namespace: #Name
#Version:   "1.0.2"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      #Name
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
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#DeploymentList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
]
