package envoy_gateway

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
	subjects: [{
		kind: "ServiceAccount"
		name: #Name
	}]
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     #Name
	}
}, {
	metadata: name: "\(#Name)-leader-election"
	subjects: [{
		kind: "ServiceAccount"
		name: #Name
	}]
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "\(#Name)-leader-election"
	}
}]
