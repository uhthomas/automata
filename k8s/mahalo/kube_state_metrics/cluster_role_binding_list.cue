package kube_state_metrics

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
