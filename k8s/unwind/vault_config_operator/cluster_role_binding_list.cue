package vault_config_operator

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
	metadata: name: "vault-config-operator-manager-rolebinding"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "vault-config-operator-manager-role"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "controller-manager"
		namespace: #Namespace
	}]
}, {
	metadata: name: "vault-config-operator-proxy-rolebinding"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "vault-config-operator-proxy-role"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "controller-manager"
		namespace: #Namespace
	}]
}]
