package grafana_agent_operator

import (
	"list"
	"k8s.io/api/core/v1"
)

#Namespace: "grafana-agent-operator"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"grafana-agent-operator"
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":      "grafana-agent-operator"
				"app.kubernetes.io/instance":  "grafana-agent-operator"
				"app.kubernetes.io/version":   "0.32.1"
				"app.kubernetes.io/component": string | *"operator"
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
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#ServiceAccountList.items,
]
