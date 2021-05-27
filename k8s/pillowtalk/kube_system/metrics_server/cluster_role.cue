package metrics_server

import rbacv1 "k8s.io/api/rbac/v1"

cluster_role: [...rbacv1.#ClusterRole]

cluster_role: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		name: "system:aggregated-metrics-reader"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-view":  "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
		}
	}
	rules: [{
		apiGroups: [
			"metrics.k8s.io",
		]
		resources: [
			"pods",
			"nodes",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: name: "system:metrics-server"
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"pods",
			"nodes",
			"nodes/stats",
			"namespaces",
			"configmaps",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}]
