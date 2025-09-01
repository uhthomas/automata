package ceph_csi

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
	metadata: name: "ceph-csi-operator-cephfs-ctrlplugin"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["csinodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "create", "delete", "patch", "update"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch", "patch", "update"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments/status"]
		verbs: ["patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["get", "list"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents"]
		verbs: ["get", "list", "watch", "patch", "update"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotcontents"]
		verbs: ["get", "list", "watch", "update", "patch"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotcontents/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: ["groupsnapshot.storage.openshift.io"]
		resources: ["volumegroupsnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["groupsnapshot.storage.openshift.io"]
		resources: ["volumegroupsnapshotcontents"]
		verbs: ["get", "list", "watch", "update", "patch"]
	}, {
		apiGroups: ["groupsnapshot.storage.openshift.io"]
		resources: ["volumegroupsnapshotcontents/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts/token"]
		verbs: ["create"]
	}, {
		apiGroups: ["authentication.k8s.io"]
		resources: ["tokenreviews"]
		verbs: ["create"]
	}]
}, {
	metadata: name: "ceph-csi-operator-cephfs-nodeplugin"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts/token"]
		verbs: ["create"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumes", "persistentvolumeclaims"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-nfs-ctrlplugin"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "create", "update", "delete", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch", "patch", "update"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["get", "list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["csinodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["get", "list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get"]
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
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments/status"]
		verbs: ["patch"]
	}]
}, {
	metadata: name: "ceph-csi-operator-nfs-nodeplugin"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-rbd-ctrlplugin"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumes"]
		verbs: ["get", "list", "watch", "create", "delete", "patch", "update"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list", "watch", "patch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments/status"]
		verbs: ["patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["csinodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents"]
		verbs: ["get", "list", "watch", "patch", "update"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshotcontents/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts/token"]
		verbs: ["create"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotcontents"]
		verbs: ["get", "list", "watch", "update", "patch"]
	}, {
		apiGroups: ["groupsnapshot.storage.k8s.io"]
		resources: ["volumegroupsnapshotcontents/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: ["groupsnapshot.storage.openshift.io"]
		resources: ["volumegroupsnapshotclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["groupsnapshot.storage.openshift.io"]
		resources: ["volumegroupsnapshotcontents"]
		verbs: ["get", "list", "watch", "update", "patch"]
	}, {
		apiGroups: ["groupsnapshot.storage.openshift.io"]
		resources: ["volumegroupsnapshotcontents/status"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: ["replication.storage.openshift.io"]
		resources: ["volumegroupreplicationcontents"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["replication.storage.openshift.io"]
		resources: ["volumegroupreplicationclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["authentication.k8s.io"]
		resources: ["tokenreviews"]
		verbs: ["create"]
	}, {
		apiGroups: ["authorization.k8s.io"]
		resources: ["subjectaccessreviews"]
		verbs: ["create"]
	}, {
		apiGroups: ["cbt.storage.k8s.io"]
		resources: ["snapshotmetadataservices"]
		verbs: ["get", "list"]
	}]
}, {
	metadata: name: "ceph-csi-operator-rbd-nodeplugin"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumes"]
		verbs: ["get", "list"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["volumeattachments"]
		verbs: ["get", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts/token"]
		verbs: ["create"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get"]
	}, {
		apiGroups: ["authentication.k8s.io"]
		resources: ["tokenreviews"]
		verbs: ["create"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims"]
		verbs: ["get"]
	}]
}]
