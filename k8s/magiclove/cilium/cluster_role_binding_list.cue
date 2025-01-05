package cilium

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
		name: "cilium"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "cilium"
		namespace: #Namespace
	}]
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cilium"
	}
}, {
	metadata: {
		name: "cilium-operator"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "cilium-operator"
		namespace: #Namespace
	}]
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cilium-operator"
	}
}]
