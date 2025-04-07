package backup

import (
	"list"

	"github.com/uhthomas/automata/k8s/magiclove/backup/breakfast"
	"github.com/uhthomas/automata/k8s/magiclove/backup/immich_unwind"
	"github.com/uhthomas/automata/k8s/magiclove/backup/legacy"
	"github.com/uhthomas/automata/k8s/magiclove/backup/lola"
	"github.com/uhthomas/automata/k8s/magiclove/backup/melonade"
	"github.com/uhthomas/automata/k8s/magiclove/backup/sana"
	"github.com/uhthomas/automata/k8s/magiclove/backup/synology"
	"k8s.io/api/core/v1"
)

#Name:      "backup"
#Namespace: #Name

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: namespace: #Namespace}]
}

#List: items: list.Concat(_items)

_items: [
	#DeploymentList.items,
	#NamespaceList.items,
	#ServiceList.items,
	breakfast.#List.items,
	immich_unwind.#List.items,
	legacy.#List.items,
	lola.#List.items,
	melonade.#List.items,
	sana.#List.items,
	synology.#List.items,
]
