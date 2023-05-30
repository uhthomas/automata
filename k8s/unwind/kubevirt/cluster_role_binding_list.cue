package kubevirt

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
	metadata: {
		name: "kubevirt-operator"
		labels: "kubevirt.io": ""
	}
	roleRef: {
		apiGroup: rbacv1.#GroupName
		kind:     "ClusterRole"
		name:     "kubevirt-operator"
	}
	subjects: [{
		kind:      rbacv1.#ServiceAccountKind
		name:      "kubevirt-operator"
		namespace: #Namespace
	}]
}]
