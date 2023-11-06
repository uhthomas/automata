package kube_system

import (
	"list"

	"github.com/uhthomas/automata/k8s/amour/kube_system/metrics_server"
	"k8s.io/api/core/v1"
)

#Namespace: "kube-system"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: namespace: #Namespace}]
}

#List: items: list.Concat(_items)

_items: [
	#NamespaceList.items,
	#VMServiceScrapeList.items,
	metrics_server.#List.items,
]
