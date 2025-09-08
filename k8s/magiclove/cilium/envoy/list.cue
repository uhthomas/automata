package envoy

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "cilium-envoy"
#Namespace: "cilium"

// renovate: datasource=github-releases depName=cilium/cilium-envoy extractVersion=^v(?<version>.*)$
#Version: "1.34.4-1754895458-68cffdfa568b6b226d70a7ef81fc65dda3b890bf"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

#List: items: list.Concat(_items)

_items: [
	#ConfigMapList.items,
	#DaemonSetList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#VMServiceScrapeList.items,
]
