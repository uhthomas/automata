package rook_ceph

import rbacv1 "k8s.io/api/rbac/v1"

#RoleBindingList: rbacv1.#RoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "RoleBinding"
	}]
}

#RoleBindingList: items: [{
	metadata: name: "cephfs-csi-provisioner-role-cfg"
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "rook-csi-cephfs-provisioner-sa"
	}]
	roleRef: {
		kind:     "Role"
		name:     "cephfs-external-provisioner-cfg"
		apiGroup: rbacv1.#GroupName
	}
}, {
	metadata: name: "rbd-csi-nodeplugin-role-cfg"
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "rook-csi-rbd-plugin-sa"
	}]
	roleRef: {
		kind:     "Role"
		name:     "rbd-csi-nodeplugin"
		apiGroup: rbacv1.#GroupName
	}
}, {
	metadata: name: "rbd-csi-provisioner-role-cfg"
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "rook-csi-rbd-provisioner-sa"
	}]
	roleRef: {
		kind:     "Role"
		name:     "rbd-external-provisioner-cfg"
		apiGroup: rbacv1.#GroupName
	}
}, {
	// Allow the operator to create resources in this cluster's namespace
	metadata: name: "rook-ceph-cluster-mgmt"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "rook-ceph-cluster-mgmt"
	}
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "rook-ceph-system"
	}]
}, {

	metadata: name: "rook-ceph-cmd-reporter"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "rook-ceph-cmd-reporter"
	}
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "rook-ceph-cmd-reporter"
	}]
}, {
	// Allow the ceph mgr to access resources scoped to the CephCluster namespace necessary for mgr modules
	metadata: name: "rook-ceph-mgr"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "rook-ceph-mgr"
	}
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "rook-ceph-mgr"
	}]
}, {
	// Allow the ceph mgr to access resources in the Rook operator namespace necessary for mgr modules
	metadata: name: "rook-ceph-mgr-system"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "rook-ceph-mgr-system"
	}
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "rook-ceph-mgr"
	}]
}, {
	// Allow the osd pods in this namespace to work with configmaps
	metadata: name: "rook-ceph-osd"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "rook-ceph-osd"
	}
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "rook-ceph-osd"
	}]
}, {
	// Allow the osd purge job to run in this namespace
	metadata: name: "rook-ceph-purge-osd"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "rook-ceph-purge-osd"
	}
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "rook-ceph-purge-osd"
	}]
}, {
	// Allow the rgw pods in this namespace to work with configmaps
	metadata: name: "rook-ceph-rgw"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "rook-ceph-rgw"
	}
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "rook-ceph-rgw"
	}]
}, {
	// Grant the operator, agent, and discovery agents access to resources in the rook-ceph-system namespace
	metadata: {
		name: "rook-ceph-system"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "rook-ceph-system"
	}
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "rook-ceph-system"
	}]
}]
