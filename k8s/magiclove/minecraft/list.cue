package minecraft

import (
	"list"

	"github.com/uhthomas/automata/k8s/magiclove/minecraft/cf_atm9"
	"github.com/uhthomas/automata/k8s/magiclove/minecraft/vanilla"
	"k8s.io/api/core/v1"
)

#Name:      "minecraft"
#Namespace: #Name
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
	cf_atm9.#List.items,
	vanilla.#List.items,
]
