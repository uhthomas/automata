package linkding

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "linkding"
#Namespace: #Name

// renovate: datasource=docker depName=sissbruecker/linkding extractVersion=^v(?<version>.*)$
#Version: "1.36.0"

_image: tools.#Image & {
	name:   "sissbruecker/linkding"
	tag:    "1.45.0-plus"
	digest: "sha256:d36c779808dd0980fc60a15167ca119b8be7f90debdd068fb038f227a87c106d"
}

_image: tag: "\(#Version)-plus"

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
	#GatewayList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
