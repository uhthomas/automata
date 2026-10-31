package depot

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "depot"
#Namespace: #Name

#Image: "ghcr.io/uhthomas/uhthomas/samba:bd3b035dfed35f2749892201f002331525c0af67"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      #Name
			namespace: #Namespace
			labels: "app.kubernetes.io/name": #Name
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ConfigMapList.items,
	#DeploymentList.items,
	#ExternalSecretList.items,
	#NamespaceList.items,
	#PasswordList.items,
	#PersistentVolumeClaimList.items,
	#ServiceList.items,
]
