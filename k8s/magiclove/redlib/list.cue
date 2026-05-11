package redlib

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "redlib"
#Namespace: #Name

// renovate: datasource=github-releases depName=redlib-org/redlib extractVersion=^v(?<version>.*)$
#Version: "721e698415e551495f38f750d03b1b8ef6866668"

_image: tools.#Image & {
	name:   "ghcr.io/uhthomas/redlib"
	tag:    "721e698415e551495f38f750d03b1b8ef6866668"
	digest: "sha256:9fc3bdd4d148b7aa9c53bb18f6651ea6ad25146ca299c1c1f247707389b27f7b"
}

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#DeploymentList.items,
	#ExternalSecretList.items,
	#GatewayList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#ServiceList.items,
]
