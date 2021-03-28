package sealed_secrets

import rbacv1 "k8s.io/api/rbac/v1"

roleBindingList: rbacv1.#RoleBindingList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBindingList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "RoleBinding"
	}]
}

roleBindingList: items: [{
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
	metadata: {
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
