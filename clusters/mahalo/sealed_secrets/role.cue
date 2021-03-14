package sealed_secrets

import rbacv1 "k8s.io/api/rbac/v1"

role: [...rbacv1.#Role]

role: [{
	apiVersion: "rbac.authorization.k8s.io/v1beta1"
	kind:       "Role"
	metadata: {
		labels: name: "sealed-secrets-key-admin"
		name: "sealed-secrets-key-admin"
	}
	rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"secrets",
		]
		verbs: [
			"create",
			"list",
		]
	}]
}, {
	apiVersion: "rbac.authorization.k8s.io/v1beta1"
	kind:       "Role"
	metadata: {
		annotations: {}
		labels: name: "sealed-secrets-service-proxier"
		name: "sealed-secrets-service-proxier"
	}
	rules: [{
		apiGroups: [
			"",
		]
		resourceNames: [
			"http:sealed-secrets-controller:",
			"sealed-secrets-controller",
		]
		resources: [
			"services/proxy",
		]
		verbs: [
			"create",
			"get",
		]
	}]
}]
