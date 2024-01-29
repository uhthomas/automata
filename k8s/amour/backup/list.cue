package backup

import (
	"list"

	"github.com/uhthomas/automata/k8s/amour/backup/breakfast"
	"github.com/uhthomas/automata/k8s/amour/backup/melonade"
	"k8s.io/api/core/v1"
)

#Name:      "backup"
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
	#NamespaceList.items,
	breakfast.#List.items,
	melonade.#List.items,
]
