package thomas

import (
	"list"

	"github.com/uhthomas/automata/k8s/unwind/thomas/inspect_filesystem"
	"github.com/uhthomas/automata/k8s/unwind/thomas/legacybackup"
	"github.com/uhthomas/automata/k8s/unwind/thomas/smartctl"
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
	#NamespaceList.items,
	inspect_filesystem.#List.items,
	legacybackup.#List.items,
	smartctl.#List.items,
	synologybackup.#List.items,
]
