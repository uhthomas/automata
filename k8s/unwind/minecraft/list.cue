package minecraft

import (
	"list"

	"github.com/uhthomas/automata/k8s/unwind/minecraft/cf_atm8"
	"github.com/uhthomas/automata/k8s/unwind/minecraft/ftb_102"
	"github.com/uhthomas/automata/k8s/unwind/minecraft/vanilla"
	"k8s.io/api/core/v1"
)

#Name: "minecraft"
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
	#SecretProviderClassList.items,
	cf_atm8.#List.items,
	ftb_102.#List.items,
	vanilla.#List.items,
]
