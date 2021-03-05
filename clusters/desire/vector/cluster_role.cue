package vector

import rbacv1 "k8s.io/api/rbac/v1"

cluster_role: [...rbacv1.#ClusterRole]

cluster_role: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: name: "vector"
	rules: [{
		apiGroups: [""]
		resources: ["pods"]
		verbs: ["watch"]
	}]
}]
