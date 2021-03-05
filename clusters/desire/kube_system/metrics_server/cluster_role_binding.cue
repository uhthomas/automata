package metrics_server

import rbacv1 "k8s.io/api/rbac/v1"

cluster_role_binding: [...rbacv1.#ClusterRoleBinding]

cluster_role_binding: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: name: "metrics-server:system:auth-delegator"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "system:auth-delegator"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "metrics-server"
		namespace: "kube-system"
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: name: "system:metrics-server"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "system:metrics-server"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "metrics-server"
		namespace: "kube-system"
	}]
}]
