package metrics_server

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
	metadata: {
		name: "system:aggregated-metrics-reader"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
			"rbac.authorization.k8s.io/aggregate-to-view":  "true"
		}
	}
	rules: [{
		apiGroups: ["metrics.k8s.io"]
		resources: ["pods", "nodes"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: name: "system:\(#Name)"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["nodes/metrics"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods", "nodes"]
		verbs: ["get", "list", "watch"]
	}]
}]
