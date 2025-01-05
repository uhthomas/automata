package snapshot_controller

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
	metadata: name: "snapshot-controller-leaderelection"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "snapshot-controller-leaderelection"
	}
	subjects: [{
		kind: rbacv1.#ServiceAccountKind
		name: "snapshot-controller"
	}]
}]
