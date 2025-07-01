package agent

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "spire-agent"
#Namespace: "spire"

// renovate: datasource=github-releases depName=spiffe/spire extractVersion=^v(?<version>.*)$
#Version: "1.12.4"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name: #Name
			labels: {
				"app.kubernetes.io/name":    #Name
				"app.kubernetes.io/version": #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#ConfigMapList.items,
	#DaemonSetList.items,
	#ServiceAccountList.items,
]
