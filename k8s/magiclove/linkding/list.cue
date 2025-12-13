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
	tag:    "1.44.2-plus"
	digest: "sha256:6d4d3d62cd07c80935a1420cc7cc2f7ac5522843d20f3612cff711243af2aeda"
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
