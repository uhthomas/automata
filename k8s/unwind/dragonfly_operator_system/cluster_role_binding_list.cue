package dragonfly_operator_system

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
		kind:      rbacv1.#ServiceAccountKind
		name:      "\(#Name)-controller-manager"
		namespace: #Namespace
	}]
}, {
	metadata: {
		name: "\(#Name)-proxy"
		labels: "app.kubernetes.io/component": "kube-rbac-proxy"
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "\(#Name)-proxy"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "\(#Name)-controller-manager"
		namespace: #Namespace
	}]
}]
