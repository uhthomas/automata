package headlamp

import (
	"k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
)

#RoleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

#RoleList: items: [{
	metadata: name: #OIDCSecretServiceAccountName
	rules: [{
		verbs: ["get", "list", "watch"]
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
	}, {
		verbs: ["create"]
		apiGroups: ["authorization.k8s.io"]
		resources: ["selfsubjectrulesreviews"]
	}]
}]
