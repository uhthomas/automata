package kanidm

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "kanidm"
#Namespace: #Name

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: "app.kubernetes.io/name": #Name
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#BackendTLSPolicyList.items,
	#ListenerSetList.items,
	#HTTPRouteList.items,
	#KanidmGroupList.items,
	#KanidmList.items,
	#KanidmOAuth2ClientList.items,
	#KanidmPersonAccountList.items,
	#NamespaceList.items,
]
