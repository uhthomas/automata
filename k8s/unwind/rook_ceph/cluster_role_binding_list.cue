package rook_ceph

import rbacv1 "k8s.io/api/rbac/v1"

clusterRoleBindingList: rbacv1.#ClusterRoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
	}]
}

clusterRoleBindingList: items: [{
	metadata: name: "cephfs-csi-provisioner-role"
	subjects: [{
		kind:      "ServiceAccount"
		name:      "rook-csi-cephfs-provisioner-sa"
		namespace: "rook-ceph"
	}]
	roleRef: {
		kind:     "ClusterRole"
		name:     "cephfs-external-provisioner-runner"
		apiGroup: "rbac.authorization.k8s.io"
	}
}, {
	metadata: name: "rbd-csi-nodeplugin"
	subjects: [{
		kind:      "ServiceAccount"
		name:      "rook-csi-rbd-plugin-sa"
		namespace: "rook-ceph"
	}]
	roleRef: {
		kind:     "ClusterRole"
		name:     "rbd-csi-nodeplugin"
		apiGroup: "rbac.authorization.k8s.io"
	}
}, {
	metadata: name: "rbd-csi-provisioner-role"
	subjects: [{
		kind:      "ServiceAccount"
		name:      "rook-csi-rbd-provisioner-sa"
		namespace: "rook-ceph"
	}]
	roleRef: {
		kind:     "ClusterRole"
		name:     "rbd-external-provisioner-runner"
		apiGroup: "rbac.authorization.k8s.io"
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
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "rook-ceph-global"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "rook-ceph-system"
		namespace: "rook-ceph"
	}]
}, {

	// Allow the ceph mgr to access cluster-wide resources necessary for the mgr modules
	metadata: name: "rook-ceph-mgr-cluster"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "rook-ceph-mgr-cluster"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "rook-ceph-mgr"
		namespace: "rook-ceph"
	}]
}, {
	// Give Rook-Ceph Operator permissions to provision ObjectBuckets in response to ObjectBucketClaims.
	metadata: name: "rook-ceph-object-bucket"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "rook-ceph-object-bucket"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "rook-ceph-system"
		namespace: "rook-ceph"
	}]
}, {

	// Allow the ceph osd to access cluster-wide resources necessary for determining their topology location
	metadata: name: "rook-ceph-osd"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "rook-ceph-osd"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "rook-ceph-osd"
		namespace: "rook-ceph"
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
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "rook-ceph-system"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "rook-ceph-system"
		namespace: "rook-ceph"
	}]
}]
