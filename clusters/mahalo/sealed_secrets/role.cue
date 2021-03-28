package sealed_secrets

import rbacv1 "k8s.io/api/rbac/v1"

roleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

roleList: items: [{
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
