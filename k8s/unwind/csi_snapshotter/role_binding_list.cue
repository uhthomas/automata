package csi_snapshotter

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
	metadata: name: "csi-provisioner-role-cfg"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "external-provisioner-cfg"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "csi-provisioner"
		namespace: #Namespace
	}]
}, {
	metadata: name: "csi-snapshotter-provisioner-role-cfg"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "external-provisioner-cfg"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "csi-snapshotter"
		namespace: #Namespace
	}]
}, {
	metadata: name: "external-snapshotter-leaderelection"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "external-snapshotter-leaderelection"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "csi-snapshotter"
		namespace: #Namespace
	}]
}]
