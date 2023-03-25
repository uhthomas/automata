package vault_config_operator

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
	metadata: name: "vault-config-operator-leader-election-rolebinding"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "vault-config-operator-leader-election-role"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "controller-manager"
		namespace: #Namespace
	}]
}, {
	metadata: name: "vault-config-operator-prometheus-k8s"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "vault-config-operator-prometheus-k8s"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "prometheus-k8s"
		namespace: #Namespace
	}]
}]
