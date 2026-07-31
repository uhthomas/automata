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
		resources: ["pods", "pods/exec"]
		verbs: ["get", "list", "watch", "create"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets", "services"]
		verbs: ["*"]
	}, {
		apiGroups: ["apps"]
		resources: ["statefulsets", "deployments"]
		verbs: ["*"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["*"]
	}, {
		apiGroups: ["events.k8s.io"]
		resources: ["events"]
		verbs: ["create", "patch"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: ["*"]
	}, {
		apiGroups: ["gateway.networking.k8s.io"]
		resources: ["httproutes", "backendtlspolicies"]
		verbs: ["*"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}]
}]
