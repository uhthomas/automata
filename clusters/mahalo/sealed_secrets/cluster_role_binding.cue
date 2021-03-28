package sealed_secrets

import rbacv1 "k8s.io/api/rbac/v1"

clusterRoleBindingList: rbacv1.#ClusterRoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
	}]
}

clusterRoleBindingList: items: [{
	metadata: {
		labels: name: "sealed-secrets-controller"
		name: "sealed-secrets-controller"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "secrets-unsealer"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "sealed-secrets-controller"
		namespace: "sealed-secrets"
	}]
}]
