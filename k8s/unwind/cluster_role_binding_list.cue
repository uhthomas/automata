package unwind

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
	metadata: name: "thomas@starjunk.net"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cluster-admin"
	}
	subjects: [{
		apiGroup: rbacv1.#GroupName
		kind:     rbacv1.#UserKind
		name:     metadata.name
	}]
}, {
	metadata: name: "tag:ci"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cluster-admin"
	}
	subjects: [{
		apiGroup: rbacv1.#GroupName
		kind:     rbacv1.#GroupKind
		name:     metadata.name
	}]
}]
