package snapscheduler

import (
	coordinationv1 "k8s.io/api/coordination/v1"
	"k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
)

#RoleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

#RoleList: items: [{
	metadata: name: "\(#Name)-leader-election"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: [coordinationv1.#GroupName]
		resources: ["leases"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}]
}]
