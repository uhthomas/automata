package grafana_agent

import "k8s.io/api/core/v1"

#Name:      "grafana-agent"
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

#List: items:
	#NamespaceList.items +
	#ClusterRoleBindingList.items +
	#ClusterRoleList.items +
	#GrafanaAgentList.items +
	#ServiceAccountList.items
