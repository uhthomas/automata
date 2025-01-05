package wireguard_operator

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
	metadata: name: "\(#Name)-manager"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "\(#Name)-manager"
	}
	subjects: [{
		name:      #Name
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}, {
	metadata: name: "\(#Name)-proxy"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "\(#Name)-proxy"
	}
	subjects: [{
		name:      #Name
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}]
