package hubble_ui

import (
	"k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
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
		name: "hubble-ui"
		labels: "app.kubernetes.io/part-of": "cilium"
	}
	rules: [{
		apiGroups: ["networking.k8s.io"]
		resources: ["networkpolicies"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["componentstatuses", "endpoints", "namespaces", "nodes", "pods", "services"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["cilium.io"]
		resources: ["*"]
		verbs: ["get", "list", "watch"]
	}]
}]
