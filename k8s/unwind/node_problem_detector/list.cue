package node_problem_detector

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "node-problem-detector"
#Namespace: #Name
#Version:   "0.8.13"

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
	// The namespace must be created first.
	#NamespaceList.items,

	// Lexicographic ordering.
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#DaemonSetList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#ServiceMonitorList.items,
]
