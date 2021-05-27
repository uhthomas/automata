package rook_ceph

import rbacv1 "k8s.io/api/rbac/v1"

roleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

roleList: items: [{
	// The role for the operator to manage resources in its own namespace
	metadata: {
		name: "rook-ceph-system"
		labels: {
			operator:          "rook"
			"storage-backend": "ceph"
		}
	}
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"pods",
			"configmaps",
			"services",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"patch",
			"create",
			"update",
			"delete",
		]
	}, {
		apiGroups: [
			"apps",
			"extensions",
		]
		resources: [
			"daemonsets",
			"statefulsets",
			"deployments",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"delete",
		]
	}, {
		apiGroups: [
			"batch",
		]
		resources: [
			"cronjobs",
		]
		verbs: [
			"delete",
		]
	}]
}, {
	metadata: name: "rook-ceph-osd"
	rules: [{
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch", "create", "update", "delete"]
	}, {
		apiGroups: ["ceph.rook.io"]
		resources: ["cephclusters", "cephclusters/finalizers"]
		verbs: ["get", "list", "create", "update", "delete"]
	}]
}, {
	// Aspects of ceph-mgr that operate within the cluster's namespace
	metadata: name: "rook-ceph-mgr"
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"pods",
			"services",
			"pods/log",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"delete",
		]
	}, {
		apiGroups: [
			"batch",
		]
		resources: [
			"jobs",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"delete",
		]
	}, {
		apiGroups: [
			"ceph.rook.io",
		]
		resources: [
			"*",
		]
		verbs: [
			"*",
		]
	}]
}, {
	metadata: name: "rook-ceph-cmd-reporter"
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"pods",
			"configmaps",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"delete",
		]
	}]
}, {
	metadata: name: "cephfs-external-provisioner-cfg"
	rules: [{
		apiGroups: [""]
		resources: ["endpoints"]
		verbs: ["get", "watch", "list", "delete", "update", "create"]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get", "list", "create", "delete"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["get", "watch", "list", "delete", "update", "create"]
	}]
}, {
	metadata: name: "rbd-external-provisioner-cfg"
	rules: [{
		apiGroups: [""]
		resources: ["endpoints"]
		verbs: ["get", "watch", "list", "delete", "update", "create"]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch", "create", "delete", "update"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["get", "watch", "list", "delete", "update", "create"]
	}]
}]
