package wireguard_operator

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
	metadata: name: "\(#Name)-leader-election"
	rules: [{
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: ["create", "patch"]
	}]
}]
