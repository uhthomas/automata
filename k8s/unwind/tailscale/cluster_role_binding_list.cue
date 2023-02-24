package tailscale

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
	metadata: name: "tailscale-operator"
	subjects: [{
		kind:      "ServiceAccount"
		name:      "operator"
		namespace: "tailscale"
	}]
	roleRef: {
		kind:     "ClusterRole"
		name:     "tailscale-operator"
		apiGroup: "rbac.authorization.k8s.io"
	}
}]
