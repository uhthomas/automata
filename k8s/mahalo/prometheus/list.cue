package prometheus

import (
	"github.com/uhthomas/automata/k8s/mahalo/prometheus/node_exporter"
	"github.com/uhthomas/automata/k8s/mahalo/prometheus/server"
	"k8s.io/api/core/v1"
)

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "prometheus"
	}]
}

list: items:
	namespaceList.items +
	node_exporter.list.items +
	server.list.items
