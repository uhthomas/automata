package envoy_gateway

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
	subjects: [{
		kind:      "ServiceAccount"
		name:      #Name
		namespace: #Namespace
	}]
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     #Name
	}
}]
