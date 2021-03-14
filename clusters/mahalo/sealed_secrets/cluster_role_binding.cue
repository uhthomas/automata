package sealed_secrets

import rbacv1 "k8s.io/api/rbac/v1"

cluster_role_binding: [...rbacv1.#ClusterRoleBinding]

cluster_role_binding: [{
	apiVersion: "rbac.authorization.k8s.io/v1beta1"
	kind:       "ClusterRoleBinding"
	metadata: {
		annotations: {}
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
