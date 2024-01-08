package metrics_server

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "metrics-server"
#Namespace: #Name
#Version:   "0.6.3"

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
	#APIServiceList.items,
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#DeploymentList.items,
	#NamespaceList.items,
	// The cluster role cheats a bit and allows access to all config maps,
	// and so this isn't required. It's used in the Helm chart, but not in
	// Kustomize? Likely because the role has to be deployed in the
	// kube-system namespace to work and therefore is a bit painful.
	//
	// #RoleBindingList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
]
