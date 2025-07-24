package snapscheduler

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
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapscheduler.backube"]
		resources: ["snapshotschedules"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["snapscheduler.backube"]
		resources: ["snapshotschedules/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["snapscheduler.backube"]
		resources: ["snapshotschedules/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}]
}]
