package reloader

import (
	appsv1 "k8s.io/api/apps/v1"
	batchv1 "k8s.io/api/batch/v1"
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
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["secrets", "configmaps"]
		verbs: ["list", "get", "watch"]
	}, {
		apiGroups: [appsv1.#GroupName]
		resources: ["deployments", "daemonsets", "statefulsets"]
		verbs: ["list", "get", "update", "patch"]
	}, {
		apiGroups: [batchv1.#GroupName]
		resources: ["cronjobs"]
		verbs: ["list", "get"]
	}, {
		apiGroups: [batchv1.#GroupName]
		resources: ["jobs"]
		verbs: ["create", "delete", "list", "get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}]
}]
