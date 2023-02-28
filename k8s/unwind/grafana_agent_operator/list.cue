package grafana_agent_operator

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"grafana-agent-operator"
			namespace: "grafana-agent-operator"
			labels: {
				"app.kubernetes.io/name":      "grafana-agent-operator"
				"app.kubernetes.io/instance":  "grafana-agent-operator"
				"app.kubernetes.io/version":   "0.31.3"
				"app.kubernetes.io/component": string | *"operator"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	clusterRoleBindingList.items +
	clusterRoleList.items +
	customResourceDefinitionList.items +
	deploymentList.items +
	serviceAccountList.items +

	// CRDs.
	metricsInstanceList.items
