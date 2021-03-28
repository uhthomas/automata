package prometheus

import (
	"github.com/uhthomas/automata/clusters/mahalo/prometheus/node_exporter"
	"github.com/uhthomas/automata/clusters/mahalo/prometheus/server"
	"k8s.io/api/core/v1"
)

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: "prometheus"
	}]
}

items:
	namespaceList.items +
	node_exporter.items +
	server.items
