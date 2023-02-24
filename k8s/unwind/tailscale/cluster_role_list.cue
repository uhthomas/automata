package tailscale

import (
	rbacv1 "k8s.io/api/rbac/v1"
	"k8s.io/api/core/v1"
)

clusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

clusterRoleList: items: [{
	metadata: name: "tailscale-operator"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: [v1.#ResourceServices, "services/status"]
		verbs: [rbacv1.#VerbAll]
	}]
}]
