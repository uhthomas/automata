package grafana_operator

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
		apiGroups: [v1.#GroupName]
		resources: ["configmaps", "persistentvolumeclaims", "secrets", "serviceaccounts", "services"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: [v1.#GroupName, "events.k8s.io"]
		resources: ["events"]
		verbs: ["create", "patch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["gateway.networking.k8s.io"]
		resources: ["httproutes"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["*"]
		verbs: ["get", "list", "patch", "watch"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["*/finalizers"]
		verbs: ["patch", "update"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["*/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}]
}]
