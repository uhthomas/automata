package tailscale

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "tailscale"
#Namespace: #Name

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
		}
	}]

}

#List: items: list.Concat(_items)

_items: [
	// The namespace must be created first.
	#NamespaceList.items,

	// Lexicographic ordering.
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#DeploymentList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#SecretProviderClassList.items,
	#ServiceAccountList.items,
]
