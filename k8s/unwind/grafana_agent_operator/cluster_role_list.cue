package grafana_agent_operator

import (
	rbacv1 "k8s.io/api/rbac/v1"
	"k8s.io/api/core/v1"
)

clusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

clusterRoleList: items: [{
	rules: [{
		apiGroups: ["monitoring.grafana.com"]
		resources: [
			"grafanaagents",
			"metricsinstances",
			"logsinstances",
			"podlogs",
			"integrations",
		]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["monitoring.grafana.com"]
		resources: [
			"grafanaagents/finalizers",
			"metricsinstances/finalizers",
			"logsinstances/finalizers",
			"podlogs/finalizers",
			"integrations/finalizers",
		]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["monitoring.coreos.com"]
		resources: [
			"podmonitors",
			"probes",
			"servicemonitors",
		]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["monitoring.coreos.com"]
		resources: [
			"podmonitors/finalizers",
			"probes/finalizers",
			"servicemonitors/finalizers",
		]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: [
			"namespaces",
			"nodes",
		]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: [
			"secrets",
			"services",
			"configmaps",
			"endpoints",
		]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: ["apps"]
		resources: [
			"statefulsets",
			"daemonsets",
			"deployments",
		]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}]
}]
