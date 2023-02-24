package tailscale

import (
	appsv1 "k8s.io/api/apps/v1"
	rbacv1 "k8s.io/api/rbac/v1"
	"k8s.io/api/core/v1"
)

roleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

roleList: items: [{
	metadata: name: "operator"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: [v1.#ResourceSecrets]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: [appsv1.#GroupName]
		resources: ["statefulsets"]
		verbs: [rbacv1.#VerbAll]
	}]
}, {
	metadata: name: "proxies"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: [v1.#ResourceSecrets]
		verbs: [rbacv1.#VerbAll]
	}]
}]
