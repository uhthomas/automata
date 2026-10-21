package redlib

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "redlib"
#Namespace: #Name

// renovate: datasource=github-releases depName=redlib-org/redlib extractVersion=^v(?<version>.*)$
#Version: "3a9031994e97bb0d8b1334bf1669cfa0c597a595"

_image: tools.#Image & {
	name:   "ghcr.io/uhthomas/redlib"
	tag:    "3a9031994e97bb0d8b1334bf1669cfa0c597a595"
	digest: "sha256:34289fd17e4e775b92b83aae91b73e398f5e78ccf6908fa2bcdf7f3cefb6720b"
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
