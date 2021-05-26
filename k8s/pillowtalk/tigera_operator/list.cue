package tigera_operator

import "k8s.io/api/core/v1"

list: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      string | *"tigera-operator"
			namespace: "tigera-operator"
			labels: {
				"app.kubernetes.io/name":      "tigera-operator"
				"app.kubernetes.io/instance":  "tigera-operator"
				"app.kubernetes.io/version":   "1.17.2"
				"app.kubernetes.io/component": "tigera-operator"
			}
		}
	}]
}

list: items:
	namespaceList.items +
	podSecurityPolicyList.items +
	serviceAccountList.items +
	customResourceDefinitionList.items +
	clusterRoleList.items +
	clusterRoleBindingList.items +
	deploymentList.items
