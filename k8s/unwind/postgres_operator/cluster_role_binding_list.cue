package postgres_operator

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
	metadata: labels: "postgres-operator.crunchydata.com/control-plane": #Name
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     #Name
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      #Name
		namespace: #Namespace
	}]
}, {
	_name: "\(#Name)-upgrade"

	metadata: {
		name: _name
		labels: "postgres-operator.crunchydata.com/control-plane": _name
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     _name
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      _name
		namespace: #Namespace
	}]
}]
