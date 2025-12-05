package redlib

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "redlib"
#Namespace: #Name

// renovate: datasource=github-releases depName=redlib-org/redlib extractVersion=^v(?<version>.*)$
#Version: "d25a7c1ce52a6b87a2f2bf9e5e8c99d92f3d639d"

_image: tools.#Image & {
	name:   "ghcr.io/uhthomas/redlib"
	tag:    "d25a7c1ce52a6b87a2f2bf9e5e8c99d92f3d639d"
	digest: "sha256:1f60367e1e33b29312cb924554de1e61bd5c3fca9442db03b4f42e8776a52f5b"
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
