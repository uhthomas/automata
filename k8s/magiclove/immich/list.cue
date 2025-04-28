package immich

import (
	"list"

	"k8s.io/api/core/v1"
	"github.com/uhthomas/automata/k8s/magiclove/immich/machine_learning"
	"github.com/uhthomas/automata/k8s/magiclove/immich/server"
	"github.com/uhthomas/automata/k8s/magiclove/immich/valkey"
)

#Name:      "immich"
#Namespace: #Name

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: namespace: #Namespace
	}]
}

#List: items: list.Concat(_items)

_items: [
	machine_learning.#List.items,
	server.#List.items,
	valkey.#List.items,
	#ClusterList.items,
	#ExternalSecretList.items,
	#GatewayList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#VMPodScrapeList.items,
]
