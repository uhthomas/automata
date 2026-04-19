package spegel

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "spegel"
#Namespace: #Name

// renovate: datasource=github-releases depName=spegel-org/spegel extractVersion=^v(?<version>.*)$
#Version: "0.7.0"

_image: tools.#Image & {
	name:   "ghcr.io/spegel-org/spegel"
	tag:    #Version
	digest: "sha256:82f5dd969ed74e3a9cfd6284045099a161778a0d85f9e01a234a62f15eb9d696"
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
	#DaemonSetList.items,
	#NamespaceList.items,
	#ServiceList.items,
	#VMServiceScrapeList.items,
]
