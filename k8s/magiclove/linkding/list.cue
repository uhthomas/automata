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
	tag:    "1.47.0-plus"
	digest: "sha256:1ba3d9ebb8be8944f771acd9bdf75d3a5d192e1fca779fe005a02fe2b798958a"
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
	#ListenerSetList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
