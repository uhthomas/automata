package sealed_secrets

import rbacv1 "k8s.io/api/rbac/v1"

role_binding: [...rbacv1.#RoleBinding]

role_binding: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		labels: name: "sealed-secrets-service-proxier"
		name: "sealed-secrets-service-proxier"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "sealed-secrets-service-proxier"
	}
	subjects: [{
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Group"
		name:     "system:authenticated"
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		annotations: {}
		labels: name: "sealed-secrets-controller"
		name:      "sealed-secrets-controller"
		namespace: "sealed-secrets"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "sealed-secrets-key-admin"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "sealed-secrets-controller"
		namespace: "sealed-secrets"
	}]
}]
