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
}]
