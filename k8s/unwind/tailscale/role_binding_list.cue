package tailscale

import rbacv1 "k8s.io/api/rbac/v1"

#RoleBindingList: rbacv1.#RoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "RoleBinding"
	}]
}

#RoleBindingList: items: [{
	metadata: name: "operator"
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "operator"
		namespace: "tailscale"
	}]
	roleRef: {
		kind:     "Role"
		name:     "operator"
		apiGroup: rbacv1.#GroupName
	}
}, {
	metadata: name: "proxies"
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "proxies"
		namespace: "tailscale"
	}]
	roleRef: {
		kind:     "Role"
		name:     "proxies"
		apiGroup: rbacv1.#GroupName
	}
}]
