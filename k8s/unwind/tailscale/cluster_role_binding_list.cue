package tailscale

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
	metadata: name: "tailscale-operator"
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "operator"
		namespace: #Namespace
	}]
	roleRef: {
		kind:     "ClusterRole"
		name:     "tailscale-operator"
		apiGroup: rbacv1.#GroupName
	}
}, {
	{
		metadata: name: "tailscale-auth-proxy"
		subjects: [{
			kind:      rbacv1.#ServiceAccountKind
			name:      "operator"
			namespace: #Namespace
		}]
		roleRef: {
			kind:     "ClusterRole"
			name:     "tailscale-auth-proxy"
			apiGroup: rbacv1.#GroupName
		}
	}
}]
