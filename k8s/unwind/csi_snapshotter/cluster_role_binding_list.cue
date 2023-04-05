package csi_snapshotter

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
	metadata: name: "csi-provisioner-role"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "external-provisioner-runner"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "csi-provisioner"
		namespace: #Namespace
	}]
}, {
	metadata: name: "csi-snapshotter-provisioner-role"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "external-provisioner-runner"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "csi-snapshotter"
		namespace: #Namespace
	}]
}, {
	metadata: name: "csi-snapshotter-role"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "external-snapshotter-runner"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "csi-snapshotter"
		namespace: #Namespace
	}]
}]
