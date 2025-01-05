package snapshot_controller

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
	metadata: name: "snapshot-controller-runner"
	rules: [{
		apiGroups: [""]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: ["list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents"]
		verbs: ["create", "get", "list", "watch", "update", "delete", "patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["get", "list", "watch", "update", "patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots/status"]
		verbs: ["update", "patch"]
	}]
}]
