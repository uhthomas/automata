package server

import rbacv1 "k8s.io/api/rbac/v1"

cluster_role_binding: [...rbacv1.#ClusterRoleBinding]

cluster_role_binding: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		name: "prometheus-server"
		labels: {
			"app.kubernetes.io/name":     "prometheus-server"
			"app.kubernetes.io/instance": "prometheus-server"
			"app.kubernetes.io/version":  "2.25.1"
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "prometheus-server"
	}
	subjects: [
		{
			kind:      "ServiceAccount"
			name:      "server"
			namespace: "prometheus"
		},
	]
}]
