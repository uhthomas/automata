package cnpg_system

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
	metadata: name: "cnpg-manager-rolebinding"
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "cnpg-manager"
		namespace: #Namespace
	}]
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cnpg-manager"
	}
}]
