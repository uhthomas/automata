package loki

import (
	"list"

	"github.com/uhthomas/automata/k8s/unwind/loki/backend"
	"github.com/uhthomas/automata/k8s/unwind/loki/gateway"
	"github.com/uhthomas/automata/k8s/unwind/loki/read"
	"github.com/uhthomas/automata/k8s/unwind/loki/write"
	"k8s.io/api/core/v1"
)

#Name:      "loki"
#Namespace: #Name
#Version:   "2.8.2"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":     #Name
				"app.kubernetes.io/instance": #Name
				"app.kubernetes.io/version":  #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	backend.#List.items,
	gateway.#List.items,
	read.#List.items,
	write.#List.items,
	#ConfigMapList.items,
	#NamespaceList.items,
	#ObjectBucketClaimList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
]
