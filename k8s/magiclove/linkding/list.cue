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
	tag:    "1.37.0-plus"
	digest: "sha256:09ee74495d0305ddaf1bcb7c1884ed51e85e8e590638d4b0a0b4054d64fc25e7"
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
	#CertificateList.items,
	#GatewayList.items,
	#HTTPRouteList.items,
	#NamespaceList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
