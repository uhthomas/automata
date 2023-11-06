package hubble_ui

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "hubble-ui"
#Namespace: "cilium"
#Version:   "1.14.2"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

#List: items: list.Concat(_items)

_items: [
	#CertificateList.items,
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#ConfigMapList.items,
	#DeploymentList.items,
	#IngressList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
]
