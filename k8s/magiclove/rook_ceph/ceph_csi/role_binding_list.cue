package ceph_csi

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
	metadata: name: "ceph-csi-operator-cephfs-ctrlplugin"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "ceph-csi-operator-cephfs-ctrlplugin"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ceph-csi-operator-cephfs-ctrlplugin-sa"
		namespace: #Namespace
	}]
}, {
	metadata: name: "ceph-csi-operator-rbd-ctrlplugin"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "ceph-csi-operator-rbd-ctrlplugin"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ceph-csi-operator-rbd-ctrlplugin-sa"
		namespace: #Namespace
	}]
}, {
	metadata: name: "ceph-csi-operator-rbd-nodeplugin"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "ceph-csi-operator-rbd-nodeplugin"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "ceph-csi-operator-rbd-nodeplugin-sa"
		namespace: #Namespace
	}]
}]
