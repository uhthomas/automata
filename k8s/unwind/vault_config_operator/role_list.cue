package vault_config_operator

import (
	"k8s.io/api/core/v1"
	coordinationv1 "k8s.io/api/coordination/v1"
	eventsv1 "k8s.io/api/events/v1"
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
	metadata: name: "vault-config-operator-leader-election-role"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: [v1.#ResourceConfigMaps]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: [coordinationv1.#GroupName]
		resources: ["leases"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: [eventsv1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}]
}, {
	metadata: name: "vault-config-operator-prometheus-k8s"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["endpoints", v1.#ResourcePods, v1.#ResourceServices]
		verbs: ["get", "list", "watch"]
	}]
}]
