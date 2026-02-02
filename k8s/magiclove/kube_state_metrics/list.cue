package kube_state_metrics

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name:      "kube-state-metrics"
#Namespace: #Name

// renovate: datasource=github-releases depName=kubernetes/kube-state-metrics extractVersion=^v(?<version>.*)$
#Version: "2.18.0"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/version":   #Version
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#NamespaceList.items,
	#RoleBindingList.items,
	#RoleList.items,
	#ServiceAccountList.items,
	#ServiceList.items,
	#StatefulSetList.items,
	#VMRuleList.items,
	#VMServiceScrapeList.items,
]
