package redlib

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "redlib"
#Namespace: #Name

// renovate: datasource=github-releases depName=redlib-org/redlib extractVersion=^v(?<version>.*)$
#Version: "60be9ccc64b6fe72e1c2af902be5bfcebee3dd28"

_image: tools.#Image & {
	name:   "ghcr.io/uhthomas/redlib"
	tag:    "60be9ccc64b6fe72e1c2af902be5bfcebee3dd28"
	digest: "sha256:b7923bde213472bbfd209d7af2d584646ecba4a7fa38a2b8fca27ae55b6ae018"
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
