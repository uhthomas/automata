package grafana_agent_operator

import rbacv1 "k8s.io/api/rbac/v1"

#ClusterRoleBindingList: rbacv1.#ClusterRoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
	}]
}

#ClusterRoleBindingList: items: [{
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "grafana-agent-operator"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "grafana-agent-operator"
		namespace: #Namespace
	}]
}]
