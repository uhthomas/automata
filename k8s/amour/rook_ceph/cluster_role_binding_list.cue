package rook_ceph

import rbacv1 "k8s.io/api/rbac/v1"

#ClusterRoleBindingList: rbacv1.#ClusterRoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
	}]
}

#ClusterRoleBindingList: items: [{
	metadata: name: "cephfs-csi-provisioner-role"
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "rook-csi-cephfs-provisioner-sa"
		namespace: #Namespace
	}]
	roleRef: {
		kind:     "ClusterRole"
		name:     "cephfs-external-provisioner-runner"
		apiGroup: rbacv1.#GroupName
	}
}, {
	metadata: name: "rbd-csi-nodeplugin"
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "rook-csi-rbd-plugin-sa"
		namespace: #Namespace
	}]
	roleRef: {
		kind:     "ClusterRole"
		name:     "rbd-csi-nodeplugin"
		apiGroup: rbacv1.#GroupName
	}
}, {
	metadata: name: "rbd-csi-provisioner-role"
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "rook-csi-rbd-provisioner-sa"
		namespace: #Namespace
	}]
	roleRef: {
		kind:     "ClusterRole"
		name:     "rbd-external-provisioner-runner"
		apiGroup: rbacv1.#GroupName
	}
}, {
	// Grant the rook system daemons cluster-wide access to manage the Rook CRDs, PVCs, and storage classes
	metadata: {
		name: "rook-ceph-global"
		labels: {
			operator:                    "rook"
			"storage-backend":           "ceph"
			"app.kubernetes.io/part-of": "rook-ceph-operator"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "rook-ceph-global"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "rook-ceph-system"
		namespace: #Namespace
	}]
}, {

	// Allow the ceph mgr to access cluster-wide resources necessary for the mgr modules
	metadata: name: "rook-ceph-mgr-cluster"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "rook-ceph-mgr-cluster"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "rook-ceph-mgr"
		namespace: #Namespace
	}]
}, {
	// Give Rook-Ceph Operator permissions to provision ObjectBuckets in response to ObjectBucketClaims.
	metadata: name: "rook-ceph-object-bucket"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "rook-ceph-object-bucket"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "rook-ceph-system"
		namespace: #Namespace
	}]
}, {

	// Allow the ceph osd to access cluster-wide resources necessary for determining their topology location
	metadata: name: "rook-ceph-osd"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "rook-ceph-osd"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "rook-ceph-osd"
		namespace: #Namespace
	}]
}, {
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
		kind:     "ClusterRole"
		name:     "rook-ceph-system"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "rook-ceph-system"
		namespace: #Namespace
	}]
}, {
	metadata: {
		name: "objectstorage-provisioner-role-binding"
		labels: {
			"app.kubernetes.io/name":      "cosi-driver-ceph"
			"app.kubernetes.io/component": "driver-ceph"
			"app.kubernetes.io/part-of":   "container-object-storage-interface"
		}
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "objectstorage-provisioner-role"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "objectstorage-provisioner"
		namespace: #Namespace
	}]
}]
