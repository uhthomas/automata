package thomas

import (
	"list"

	"github.com/uhthomas/automata/k8s/unwind/thomas/synologybackup"
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

_items: [
	#JobList.items,
	#NamespaceList.items,
	synologybackup.#List.items,
]
