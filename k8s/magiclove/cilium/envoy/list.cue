package envoy

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "cilium-envoy"
#Namespace: "cilium"

// renovate: datasource=github-releases depName=cilium/cilium-envoy extractVersion=^v(?<version>.*)$
#Version: "1.35.9-1773656288-7b052e66eb2cfc5ac130ce0a5be66202a10d83be"

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
