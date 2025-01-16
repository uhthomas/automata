package server

import rbacv1 "k8s.io/api/rbac/v1"

#ClusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

#ClusterRoleList: items: [{
	rules: [{
		apiGroups: ["authentication.k8s.io"]
		resources: ["tokenreviews"]
		verbs: ["create"]
	}]
}]
