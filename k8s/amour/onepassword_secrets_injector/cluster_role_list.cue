package onepassword_secrets_injector

import rbacv1 "k8s.io/api/rbac/v1"

#ClusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

#ClusterRoleList: items: [{
	rules: [{
		apiGroups: ["admissionregistration.k8s.io"]
		resources: ["mutatingwebhookconfigurations"]
		verbs: ["create", "get", "delete", "list", "patch", "update", "watch"]
	}]
}]
