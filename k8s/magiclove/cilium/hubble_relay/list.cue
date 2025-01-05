package hubble_relay

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "hubble-relay"
#Namespace: "cilium"

// renovate: datasource=github-releases depName=cilium/cilium extractVersion=^v(?<version>.*)$
#Version: "1.16.1"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

#List: items: list.Concat(_items)

_items: [
	#CertificateList.items,
	#ConfigMapList.items,
	#DeploymentList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
]
