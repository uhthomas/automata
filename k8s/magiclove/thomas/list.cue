package thomas

import (
	"list"
	"k8s.io/api/core/v1"
)

#Name:      "thomas"
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

_items: [#NamespaceList.items]
