package ceph_csi_operator

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
	metadata: name: "ceph-csi-operator-manager-rolebinding"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "ceph-csi-operator-manager-role"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ceph-csi-operator-controller-manager"
		namespace: #Namespace
	}]
}, {
	metadata: name: "ceph-csi-operator-metrics-auth-rolebinding"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "ceph-csi-operator-metrics-auth-role"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ceph-csi-operator-controller-manager"
		namespace: #Namespace
	}]
}, {
	metadata: name: "ceph-csi-operator-cephfs-ctrlplugin"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "ceph-csi-operator-cephfs-ctrlplugin"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ceph-csi-operator-cephfs-ctrlplugin"
		namespace: #Namespace
	}]
}, {
	metadata: name: "ceph-csi-operator-cephfs-nodeplugin"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "ceph-csi-operator-cephfs-nodeplugin"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ceph-csi-operator-cephfs-nodeplugin"
		namespace: #Namespace
	}]
}, {
	metadata: name: "ceph-csi-operator-nfs-ctrlplugin"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "ceph-csi-operator-nfs-ctrlplugin"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ceph-csi-operator-nfs-ctrlplugin"
		namespace: #Namespace
	}]
}, {
	metadata: name: "ceph-csi-operator-nfs-nodeplugin"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "ceph-csi-operator-nfs-nodeplugin"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ceph-csi-operator-nfs-nodeplugin"
		namespace: #Namespace
	}]
}, {
	metadata: name: "ceph-csi-operator-rbd-ctrlplugin"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "ceph-csi-operator-rbd-ctrlplugin"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ceph-csi-operator-rbd-ctrlplugin"
		namespace: #Namespace
	}]
}, {
	metadata: name: "ceph-csi-operator-rbd-nodeplugin"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "ceph-csi-operator-rbd-nodeplugin"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ceph-csi-operator-rbd-nodeplugin"
		namespace: #Namespace
	}]
}]
