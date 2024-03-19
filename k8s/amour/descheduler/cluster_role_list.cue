package descheduler

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
		apiGroups: ["events.k8s.io"]
		resources: ["events"]
		verbs: ["create", "update"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get", "watch", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["namespaces"]
		verbs: ["get", "watch", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods"]
		verbs: ["get", "watch", "list", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods/eviction"]
		verbs: ["create"]
	}, {
		apiGroups: ["scheduling.k8s.io"]
		resources: ["priorityclasses"]
		verbs: ["get", "watch", "list"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["create"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		resourceNames: ["descheduler"]
		verbs: ["get", "patch", "delete"]
	}]
}]
