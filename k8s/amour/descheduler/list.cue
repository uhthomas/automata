package descheduler

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "descheduler"
#Namespace: #Name

// renovate: datasource=github-releases depName=kubernetes-sigs/descheduler extractVersion=^v(?<version>.*)$
#Version: "0.29.0"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      #Name
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
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#ConfigMapList.items,
	#CronJobList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
]
