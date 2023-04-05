package csi_snapshotter

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
	metadata: name: "external-provisioner-runner"
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "create", "delete"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: ["list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["get", "list"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents"]
		verbs: ["get", "list"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["csinodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: name: "external-snapshotter-runner"
	rules: [{
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
		verbs: ["get", "list", "watch", "update", "patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents/status"]
		verbs: ["update", "patch"]
	}]
}]
