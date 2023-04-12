package redis_operator

import rbacv1 "k8s.io/api/rbac/v1"

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
		apiGroups: ["databases.spotahome.com"]
		resources: ["redisfailovers", "redisfailovers/finalizers"]
		verbs: ["*"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["*"]
	}, {
		apiGroups: [""]
		resources: ["pods", "services", "endpoints", "events", "configmaps", "persistentvolumeclaims", "persistentvolumeclaims/finalizers"]
		verbs: ["*"]
	}, {
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments", "statefulsets"]
		verbs: ["*"]
	}, {
		apiGroups: ["policy"]
		resources: ["poddisruptionbudgets"]
		verbs: ["*"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["*"]
	}]
}]
