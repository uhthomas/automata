package metrics_server

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
	metadata: name: "\(#Name):system:auth-delegator"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "system:auth-delegator"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      #Name
		namespace: #Namespace
	}]
}, {
	metadata: name: "system:\(#Name)"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "system:\(#Name)"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      #Name
		namespace: #Namespace
	}]
}]
