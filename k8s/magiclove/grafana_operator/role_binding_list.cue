package grafana_operator

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
	metadata: name: "\(#Name)-leases"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "\(#Name)-leases"
	}
	subjects: [{
		name:      #Name
		namespace: #Namespace
		kind:      rbacv1.#ServiceAccountKind
	}]
}]
