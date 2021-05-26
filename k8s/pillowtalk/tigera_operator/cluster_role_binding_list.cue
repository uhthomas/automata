package tigera_operator

import rbacv1 "k8s.io/api/rbac/v1"

clusterRoleBindingList: rbacv1.#ClusterRoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
	}]
}

clusterRoleBindingList: items: [{
	// Source: tigera-operator/templates/tigera-operator/02-rolebinding-tigera-operator.yaml
	subjects: [{
		kind:      "ServiceAccount"
		name:      "tigera-operator"
		namespace: "tigera-operator"
	}]
	roleRef: {
		kind:     "ClusterRole"
		name:     "tigera-operator"
		apiGroup: "rbac.authorization.k8s.io"
	}
}]
