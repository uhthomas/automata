package kaniop

import (
	rbacv1 "k8s.io/api/rbac/v1"
	"k8s.io/api/core/v1"
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
		apiGroups: ["kaniop.rs"]
		resources: ["*"]
		verbs: ["*"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["namespaces"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods/exec", "secrets", "services"]
		verbs: ["*"]
	}, {
		apiGroups: ["apps"]
		resources: ["statefulsets"]
		verbs: ["*"]
	}, {
		apiGroups: ["events.k8s.io"]
		resources: ["events"]
		verbs: ["create", "patch"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: ["*"]
	}]
}]
