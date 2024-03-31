package trivy_system

import rbacv1 "k8s.io/api/rbac/v1"

#RoleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

#RoleList: items: [{
	rules: [{
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["create", "get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["create", "get", "delete"]
	}]
}, {
	metadata: name: "\(#Name)-leader-election"
	rules: [{
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["create", "get", "update"]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: ["create"]
	}]
}]
