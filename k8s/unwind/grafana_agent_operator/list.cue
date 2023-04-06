package grafana_agent_operator

import (
	"list"
	"k8s.io/api/core/v1"
)

#Name:      "grafana-agent-operator"
#Namespace: #Name
#Version:   "0.32.1"

#List: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *#Name
			namespace: #Namespace
			labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/version":   "0.32.1"
				"app.kubernetes.io/component": string | *"operator"
			}
		}
	}]
}

#List: items: list.Concat(_items)

_items: [
	#ClusterRoleBindingList.items,
	#ClusterRoleList.items,
	#CustomResourceDefinitionList.items,
	#DeploymentList.items,
	#NamespaceList.items,
	#ServiceAccountList.items,
]
