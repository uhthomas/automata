package scrutiny

import (
	"list"

	"github.com/uhthomas/automata/k8s/amour/scrutiny/collector"
	"github.com/uhthomas/automata/k8s/amour/scrutiny/influxdb"
	"github.com/uhthomas/automata/k8s/amour/scrutiny/web"
	"k8s.io/api/core/v1"
)

#Name:      "scrutiny"
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
	collector.#List.items,
	influxdb.#List.items,
	web.#List.items,
]
