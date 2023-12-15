package node_feature_discovery

import (
	"list"

	"github.com/uhthomas/automata/k8s/amour/node_feature_discovery/gc"
	"github.com/uhthomas/automata/k8s/amour/node_feature_discovery/master"
	"github.com/uhthomas/automata/k8s/amour/node_feature_discovery/worker"
	"k8s.io/api/core/v1"
)

#Name:      "node-feature-discovery"
#Namespace: #Name
#Version:   "0.14.3"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    string | *#Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#CustomResourceDefinitionList.items,
	#NamespaceList.items,
	gc.#List.items,
	master.#List.items,
	worker.#List.items,
]
