package vector

import rbacv1 "k8s.io/api/rbac/v1"

cluster_role_binding: [...rbacv1.#ClusterRoleBinding]

cluster_role_binding: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: name: "vector"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "vector"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "vector"
		namespace: "vector"
	}]
}]
