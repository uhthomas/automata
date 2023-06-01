package minecraft

import (
	"list"

	"github.com/uhthomas/automata/k8s/unwind/minecraft/ftb_102"
	"github.com/uhthomas/automata/k8s/unwind/minecraft/vanilla"
	"k8s.io/api/core/v1"
)

#Namespace: "minecraft"
#Version:   "2023.3.0"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			namespace: #Namespace
			labels: "app.kubernetes.io/version": #Version
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#NamespaceList.items,
	ftb_102.#List.items,
	vanilla.#List.items,
]
