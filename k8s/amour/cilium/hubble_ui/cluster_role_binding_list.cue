package hubble_ui

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
	metadata: {
		name: "hubble-ui"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "hubble-ui"
		namespace: "cilium"
	}]
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "hubble-ui"
	}
}]
