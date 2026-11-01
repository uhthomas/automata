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

#SambaImage: "ghcr.io/uhthomas/uhthomas/samba:bd3b035dfed35f2749892201f002331525c0af67"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: namespace: #Namespace}]
}

#List: items: list.Concat(_items)

_items: [
	#ConfigMapList.items,
	#DeploymentList.items,
	#ExternalSecretList.items,
	#NamespaceList.items,
	#PasswordList.items,
	#ServiceList.items,
	breakfast.#List.items,
	immich_unwind.#List.items,
	legacy.#List.items,
	lola.#List.items,
	melonade.#List.items,
	sana.#List.items,
	synology.#List.items,
]
