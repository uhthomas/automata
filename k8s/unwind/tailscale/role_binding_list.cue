package tailscale

import rbacv1 "k8s.io/api/rbac/v1"

roleBindingList: rbacv1.#RoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "RoleBinding"
	}]
}

roleBindingList: items: [{
	metadata: name: "operator"
	subjects: [{
		kind:      "ServiceAccount"
		name:      "operator"
		namespace: "tailscale"
	}]
	roleRef: {
		kind:     "Role"
		name:     "operator"
		apiGroup: "rbac.authorization.k8s.io"
	}
}, {
	metadata: name: "proxies"
	subjects: [{
		kind:      "ServiceAccount"
		name:      "proxies"
		namespace: "tailscale"
	}]
	roleRef: {
		kind:     "Role"
		name:     "proxies"
		apiGroup: "rbac.authorization.k8s.io"
	}
}]
