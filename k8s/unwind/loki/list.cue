package loki

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "loki"
#Namespace: #Name
#Version:   "2.7.3"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":     #Name
				"app.kubernetes.io/instance": #Name
				"app.kubernetes.io/version":  #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	// The namespace must be created first.
	#NamespaceList.items,

	// Lexicographic ordering.
	#ConfigMapList.items,
	#DeploymentList.items,
	#ObjectBucketClaimList.items,
	#PodDisruptionBudgetList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#StatefulSetList.items,
]
