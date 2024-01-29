package hubble_relay

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "hubble-relay"
#Namespace: "cilium"
#Version:   "1.15.0-rc.0"

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
