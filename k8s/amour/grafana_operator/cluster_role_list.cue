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
		resources: ["configmaps"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps", "persistentvolumeclaims", "secrets", "serviceaccounts", "services"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "get", "list", "patch", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanaalertrulegroups"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanaalertrulegroups/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanaalertrulegroups/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanadashboards"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanadashboards/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanadashboards/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanadatasources"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanadatasources/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanadatasources/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanafolders"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanafolders/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanafolders/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanas"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanas/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["grafana.integreatly.org"]
		resources: ["grafanas/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["route.openshift.io"]
		resources: ["routes", "routes/custom-host"]
		verbs: ["create", "delete", "get", "list", "update", "watch"]
	}]
}]
