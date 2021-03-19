package kube_state_metrics

import rbacv1 "k8s.io/api/rbac/v1"

cluster_role_binding: [...rbacv1.#ClusterRoleBinding]

cluster_role_binding: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "kube-state-metrics"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "kube-state-metrics"
		namespace: "kube-state-metrics"
	}]
}]
