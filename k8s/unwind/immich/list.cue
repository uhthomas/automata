package immich

import (
	"list"

	"github.com/uhthomas/automata/k8s/unwind/immich/cockroach"
	"github.com/uhthomas/automata/k8s/unwind/immich/immich_machine_learning"
	"github.com/uhthomas/automata/k8s/unwind/immich/immich_microservice"
	"github.com/uhthomas/automata/k8s/unwind/immich/immich_proxy"
	"github.com/uhthomas/automata/k8s/unwind/immich/immich_server"
	"github.com/uhthomas/automata/k8s/unwind/immich/immich_web"
	"github.com/uhthomas/automata/k8s/unwind/immich/redis"
	"github.com/uhthomas/automata/k8s/unwind/immich/typesense"
	"k8s.io/api/core/v1"
)

#Name:      "immich"
#Namespace: #Name

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{metadata: namespace: #Namespace}]

}

#List: items: list.Concat(_items)

_items: [
	#NamespaceList.items,
	#PersistentVolumeClaimList.items,
	#PostgresClusterList.items,
	#SecretProviderClassList.items,
	cockroach.#List.items,
	immich_machine_learning.#List.items,
	immich_microservice.#List.items,
	immich_proxy.#List.items,
	immich_server.#List.items,
	immich_web.#List.items,
	redis.#List.items,
	typesense.#List.items,
]
