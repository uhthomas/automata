package redlib

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "redlib"
#Namespace: #Name

// renovate: datasource=github-releases depName=redlib-org/redlib extractVersion=^v(?<version>.*)$
#Version: "3dda94cfc7c41eab47d5040e84155ad2b3bc6123"

_image: tools.#Image & {
	name:   "ghcr.io/uhthomas/redlib"
	tag:    "3dda94cfc7c41eab47d5040e84155ad2b3bc6123"
	digest: "sha256:8c268a627ba9563058ad665b1cdb00b908edeaac18eabd542e8bf5828890d72f"
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
