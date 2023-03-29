package grafana_agent

import (
	"list"

	"k8s.io/api/core/v1"
)

#Name: "grafana-agent"

#Namespace: #Name

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
				"app.kubernetes.io/version":  "0.32.1"
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
	#GrafanaAgentList.items,
	#IntegrationList.items,
	#LogsInstanceList.items,
	#MetricsInstanceList.items,
	#PersistentVolumeClaimList.items,
	#PodLogsList.items,
	#PodMonitorList.items,
	#SecretProviderClassList.items,
	#ServiceAccountList.items,
	#ServiceMonitorList.items,
]
