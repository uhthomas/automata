package prowlarr

import (
	rbacv1 "k8s.io/api/rbac/v1"
	"k8s.io/api/core/v1"
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
	metadata: name: "\(#Name)-tailscale-state"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: [v1.#ResourceSecrets]
		verbs: ["create"]
	}, {
		apiGroups: [v1.#GroupName]
		resourceNames: [metadata.name]
		resources: [v1.#ResourceSecrets]
		verbs: ["get", "update", "patch"]
	}]
}]
