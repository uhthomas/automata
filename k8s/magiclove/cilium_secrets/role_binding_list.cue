package cilium_secrets

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
	metadata: {
		name: "cilium-gateway-secrets"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "cilium-gateway-secrets"
	}
	subjects: [{
		name:      "cilium"
		kind:      rbacv1.#ServiceAccountKind
		namespace: "cilium"
	}]
}, {
	metadata: {
		name: "cilium-operator-gateway-secrets"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "cilium-operator-gateway-secrets"
	}
	subjects: [{
		name:      "cilium-operator"
		kind:      rbacv1.#ServiceAccountKind
		namespace: "cilium"
	}]
}]
