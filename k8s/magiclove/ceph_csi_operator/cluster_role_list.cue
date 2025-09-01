package ceph_csi_operator

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
	metadata: name: "ceph-csi-operator-cephconnection-viewer-role"
	rules: [{
		apiGroups: ["csi.ceph.io"]
		resources: ["cephconnections"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["cephconnections/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-cephconnections-editor-role"
	rules: [{
		apiGroups: ["csi.ceph.io"]
		resources: ["cephconnections"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["cephconnections/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-clientprofile-viewer-role"
	rules: [{
		apiGroups: ["csi.ceph.io"]
		resources: ["clientprofiles"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["clientprofiles/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-clientprofilemapping-editor-role"
	rules: [{
		apiGroups: ["csi.ceph.io"]
		resources: ["clientprofilemappings"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["clientprofilemappings/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-clientprofilemapping-viewer-role"
	rules: [{
		apiGroups: ["csi.ceph.io"]
		resources: ["clientprofilemappings"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["clientprofilemappings/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-clientprofiles-editor-role"
	rules: [{
		apiGroups: ["csi.ceph.io"]
		resources: ["clientprofiles"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["clientprofiles/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-driver-editor-role"
	rules: [{
		apiGroups: ["csi.ceph.io"]
		resources: ["drivers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["drivers/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-driver-viewer-role"
	rules: [{
		apiGroups: ["csi.ceph.io"]
		resources: ["drivers"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["drivers/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-manager-role"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["configmaps", "services"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["daemonsets", "deployments"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["cbt.storage.k8s.io"]
		resources: ["snapshotmetadataservices"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["cephconnections"]
		verbs: ["delete", "get", "list", "update", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["clientprofilemappings", "clientprofiles", "drivers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["clientprofilemappings/finalizers", "clientprofiles/finalizers", "drivers/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["clientprofilemappings/status", "clientprofiles/status", "drivers/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["operatorconfigs"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["csidrivers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}]
}, {
	metadata: name: "ceph-csi-operator-metrics-auth-role"
	rules: [{
		apiGroups: ["authentication.k8s.io"]
		resources: ["tokenreviews"]
		verbs: ["create"]
	}, {
		apiGroups: ["authorization.k8s.io"]
		resources: ["subjectaccessreviews"]
		verbs: ["create"]
	}]
}, {
	metadata: name: "ceph-csi-operator-metrics-reader"
	rules: [{
		nonResourceURLs: ["/metrics"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-operatorconfig-editor-role"
	rules: [{
		apiGroups: ["csi.ceph.io"]
		resources: ["operatorconfigs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["operatorconfigs/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "ceph-csi-operator-operatorconfig-viewer-role"
	rules: [{
		apiGroups: ["csi.ceph.io"]
		resources: ["operatorconfigs"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["csi.ceph.io"]
		resources: ["operatorconfigs/status"]
		verbs: ["get"]
	}]
}, {
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
