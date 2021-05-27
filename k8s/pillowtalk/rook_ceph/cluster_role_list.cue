package rook_ceph

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
	metadata: name: "rook-ceph-admission-controller-role"
	rules: [{
		apiGroups: ["ceph.rook.io"]
		resources: ["*"]
		verbs: ["get", "watch", "list"]
	}]
}, {
	// The cluster role for managing all the cluster-specific resources in a namespace
	metadata: {
		name: "rook-ceph-cluster-mgmt"
		labels: {
			operator:          "rook"
			"storage-backend": "ceph"
		}
	}
	rules: [{
		apiGroups: [
			"",
			"apps",
			"extensions",
		]
		resources: [
			"secrets",
			"pods",
			"pods/log",
			"services",
			"configmaps",
			"deployments",
			"daemonsets",
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
	}]
}, {
	// The cluster role for managing the Rook CRDs
	metadata: {
		name: "rook-ceph-global"
		labels: {
			operator:          "rook"
			"storage-backend": "ceph"
		}
	}
	rules: [{
		apiGroups: [
			"",
		]
		resources:
		// Pod access is needed for fencing
		[
			"pods",
			"nodes",
			"nodes/proxy",
			"services",
		]
		// Node access is needed for determining nodes where mons should run
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"",
		]
		resources: [
			"events",
			"persistentvolumes",
			"persistentvolumeclaims",
			"endpoints",
		]
		// PVs and PVCs are managed by the Rook provisioner
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
			"storage.k8s.io",
		]
		resources: [
			"storageclasses",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"batch",
		]
		resources: [
			"jobs",
			"cronjobs",
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
	}, {
		apiGroups: [
			"rook.io",
		]
		resources: [
			"*",
		]
		verbs: [
			"*",
		]
	}, {
		apiGroups: [
			"policy",
			"apps",
			"extensions",
		]
		resources:
		// This is for the clusterdisruption controller
		[
			"poddisruptionbudgets",
			"deployments",
			"replicasets",
		]
		// This is for both clusterdisruption and nodedrain controllers
		verbs: [
			"*",
		]
	}, {
		apiGroups: [
			"healthchecking.openshift.io",
		]
		resources: [
			"machinedisruptionbudgets",
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
			"machine.openshift.io",
		]
		resources: [
			"machines",
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
			"storage.k8s.io",
		]
		resources: [
			"csidrivers",
		]
		verbs: [
			"create",
			"delete",
			"get",
			"update",
		]
	}, {
		apiGroups: [
			"k8s.cni.cncf.io",
		]
		resources: [
			"network-attachment-definitions",
		]
		verbs: [
			"get",
		]
	}]
}, {
	// Aspects of ceph-mgr that require cluster-wide access
	metadata: {
		name: "rook-ceph-mgr-cluster"
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
			"configmaps",
			"nodes",
			"nodes/proxy",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"",
		]
		resources: [
			"events",
		]
		verbs: [
			"create",
			"patch",
			"list",
			"get",
			"watch",
		]
	}]
}, {
	metadata: {
		name: "rook-ceph-object-bucket"
		labels: {
			operator:          "rook"
			"storage-backend": "ceph"
		}
	}
	rules: [{
		apiGroups: [
			"",
		]
		verbs: [
			"*",
		]
		resources: [
			"secrets",
			"configmaps",
		]
	}, {
		apiGroups: [
			"storage.k8s.io",
		]
		resources: [
			"storageclasses",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"objectbucket.io",
		]
		verbs: [
			"*",
		]
		resources: [
			"*",
		]
	}]
}, {
	metadata: name: "rook-ceph-osd"
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"nodes",
		]
		verbs: [
			"get",
			"list",
		]
	}]
}, {
	// Aspects of ceph-mgr that require access to the system namespace
	metadata: name: "rook-ceph-mgr-system"
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"configmaps",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}, {
	metadata: name: "psp:rook"
	rules: [{
		apiGroups: [
			"policy",
		]
		resources: [
			"podsecuritypolicies",
		]
		resourceNames: [
			"00-rook-privileged",
		]
		verbs: [
			"use",
		]
	}]
}, {
	metadata: name: "cephfs-csi-nodeplugin"
	rules: [{
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["get", "list", "update"]
	}, {
		apiGroups: [""]
		resources: ["namespaces"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get", "list"]
	}]
}, {
	metadata: name: "cephfs-external-provisioner-runner"
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "create", "delete", "update", "patch"]
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
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents"]
		verbs: ["create", "get", "list", "watch", "update", "delete"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents/status"]
		verbs: ["update"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["create", "list", "watch", "delete", "get", "update"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots/status"]
		verbs: ["update"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch", "update", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments/status"]
		verbs: ["patch"]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims/status"]
		verbs: ["update", "patch"]
	}]
}, {
	metadata: name: "rbd-csi-nodeplugin"
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["get", "list", "update"]
	}, {
		apiGroups: [""]
		resources: ["namespaces"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get", "list"]
	}]
}, {
	metadata: name: "rbd-external-provisioner-runner"
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "create", "delete", "update", "patch"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch", "update", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments/status"]
		verbs: ["patch"]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: ["get", "list", "watch"]
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
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents"]
		verbs: ["create", "get", "list", "watch", "update", "delete"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents/status"]
		verbs: ["update"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["create", "list", "watch", "delete", "get", "update"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots/status"]
		verbs: ["update"]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: ["replication.storage.openshift.io"]
		resources: ["volumereplications", "volumereplicationclasses"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["replication.storage.openshift.io"]
		resources: ["volumereplications/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["replication.storage.openshift.io"]
		resources: ["volumereplications/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["replication.storage.openshift.io"]
		resources: ["volumereplicationclasses/status"]
		verbs: ["get"]
	}]
}]
