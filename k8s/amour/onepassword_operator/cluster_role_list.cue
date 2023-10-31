package onepassword_operator

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
		resources: ["pods", "services", "services/finalizers", "endpoints", "persistentvolumeclaims", "events", "configmaps", "secrets", "namespaces"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments", "daemonsets", "replicasets", "statefulsets"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["monitoring.coreos.com"]
		resources: ["servicemonitors"]
		verbs: ["get", "create"]
	}, {
		apiGroups: ["apps"]
		resourceNames: ["onepassword-operator"]
		resources: ["deployments/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: [""]
		resources: ["pods"]
		verbs: ["get"]
	}, {
		apiGroups: ["apps"]
		resources: ["replicasets", "deployments"]
		verbs: ["get"]
	}, {
		apiGroups: ["onepassword.com"]
		resources: ["*"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}]
}]
