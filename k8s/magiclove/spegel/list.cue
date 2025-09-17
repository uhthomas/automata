package spegel

import (
	"list"

	"k8s.io/api/core/v1"

	"github.com/uhthomas/automata/tools"
)

#Name:      "spegel"
#Namespace: #Name

// renovate: datasource=github-releases depName=spegel-org/spegel extractVersion=^v(?<version>.*)$
#Version: "0.4.0"

_image: tools.#Image & {
	name:   "ghcr.io/spegel-org/spegel"
	tag:    #Version
	digest: "sha256:a86089ae74c4f9c98ec86c366d196f7a03044c38af09e6582b0661d42a324226"
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
