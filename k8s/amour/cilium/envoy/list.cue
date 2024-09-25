package envoy

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "cilium-envoy"
#Namespace: "cilium"

// renovate: datasource=github-releases depName=cilium/cilium-envoy extractVersion=^v(?<version>.*)$
#Version: "1.29.7-39a2a56bbd5b3a591f69dbca51d3e30ef97e0e51"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

#List: items: list.Concat(_items)

_items: [
	#ConfigMapList.items,
	#DaemonSetList.items,
	#ServiceAccountList.items,
	#VMPodScrapeList.items,
]
