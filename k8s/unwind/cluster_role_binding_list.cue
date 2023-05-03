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

#ClusterRoleBindingList: items: [ for _name in [
	"thomas@starjunk.net",
	"github-automata-unwind-k8s-apply.tailnet-fbec.ts.net",
] {
	metadata: name: _name
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "cluster-admin"
	}
	subjects: [{
		apiGroup: rbacv1.#GroupName
		kind:     rbacv1.#UserKind
		name:     _name
	}]
}]
