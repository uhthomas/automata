package spire

import (
	"list"

	"github.com/uhthomas/automata/k8s/magiclove/spire/agent"
	"github.com/uhthomas/automata/k8s/magiclove/spire/client"
	"github.com/uhthomas/automata/k8s/magiclove/spire/server"
	"k8s.io/api/core/v1"
)

#Name:      "spire"
#Namespace: #Name

// renovate: datasource=github-releases depName=spiffe/spire extractVersion=^v(?<version>.*)$
#Version: "1.12.4"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    string | *#Name
				"app.kubernetes.io/version": string | *#Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ConfigMapList.items,
	#NamespaceList.items,
	agent.#List.items,
	client.#List.items,
	server.#List.items,
]
