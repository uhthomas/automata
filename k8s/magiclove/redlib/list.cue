package redlib

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "redlib"
#Namespace: #Name

// renovate: datasource=github-releases depName=redlib-org/redlib extractVersion=^v(?<version>.*)$
#Version: "a15c0a197d92721cba1a4e935f0a8551be0cd2a7"

_image: tools.#Image & {
	name:   "ghcr.io/uhthomas/redlib"
	tag:    "a15c0a197d92721cba1a4e935f0a8551be0cd2a7"
	digest: "sha256:0fd6819f4380be68bf15b0cd6f120479639da2ed44b4787c637b0806f9897871"
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
	#ListenerSetList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#ServiceList.items,
]
