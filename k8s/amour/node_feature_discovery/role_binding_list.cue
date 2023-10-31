package node_feature_discovery

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
	metadata: name: "nfd-worker"
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "Role"
		name:     "nfd-worker"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "nfd-worker"
		namespace: #Namespace
	}]
}]
