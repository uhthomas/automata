package metrics_server

import rbacv1 "k8s.io/api/rbac/v1"

clusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

clusterRoleList: items: [{
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
