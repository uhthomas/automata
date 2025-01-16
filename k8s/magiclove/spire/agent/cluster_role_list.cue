package agent

import (
	"k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
)

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
		apiGroups: [v1.#GroupName]
		resources: ["pods", "nodes", "nodes/proxy"]
		verbs: ["get"]
	}]
}]
