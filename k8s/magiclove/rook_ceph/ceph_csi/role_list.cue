package ceph_csi

import (
	"k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
)

#RoleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

#RoleList: items: [{
	metadata: name: "ceph-csi-operator-cephfs-ctrlplugin"
	rules: [{
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["get", "watch", "list", "delete", "update", "create"]
	}, {
		apiGroups: ["csiaddons.openshift.io"]
		resources: ["csiaddonsnodes"]
		verbs: ["get", "watch", "list", "create", "update", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods"]
		verbs: ["get"]
	}, {
		apiGroups: ["apps"]
		resources: ["replicasets"]
		verbs: ["get"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments/finalizers", "daemonsets/finalizers"]
		verbs: ["update"]
	}]
}, {
	metadata: name: "ceph-csi-operator-rbd-ctrlplugin"
	rules: [{
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["get", "watch", "list", "delete", "update", "create"]
	}, {
		apiGroups: ["csiaddons.openshift.io"]
		resources: ["csiaddonsnodes"]
		verbs: ["get", "watch", "list", "create", "update", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods"]
		verbs: ["get"]
	}, {
		apiGroups: ["apps"]
		resources: ["replicasets"]
		verbs: ["get"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments/finalizers", "daemonsets/finalizers"]
		verbs: ["update"]
	}]
}, {
	metadata: name: "ceph-csi-operator-rbd-nodeplugin"
	rules: [{
		apiGroups: ["csiaddons.openshift.io"]
		resources: ["csiaddonsnodes"]
		verbs: ["get", "watch", "list", "create", "update", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods"]
		verbs: ["get"]
	}, {
		apiGroups: ["apps"]
		resources: ["replicasets"]
		verbs: ["get"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments/finalizers", "daemonsets/finalizers"]
		verbs: ["update"]
	}]
}]
