package gc

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
		resources: ["nodes"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes/proxy"]
		verbs: ["get"]
	}, {
		apiGroups: ["topology.node.k8s.io"]
		resources: ["noderesourcetopologies"]
		verbs: ["delete", "list"]
	}, {
		apiGroups: ["nfd.k8s-sigs.io"]
		resources: ["nodefeatures"]
		verbs: ["delete", "list"]
	}]
}]
