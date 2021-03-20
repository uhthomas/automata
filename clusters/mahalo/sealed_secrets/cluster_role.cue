package sealed_secrets

import rbacv1 "k8s.io/api/rbac/v1"

cluster_role: [...rbacv1.#ClusterRole]

cluster_role: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: name: "secrets-unsealer"
		name: "secrets-unsealer"
	}
	rules: [{
		apiGroups: [
			"bitnami.com",
		]
		resources: [
			"sealedsecrets",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"bitnami.com",
		]
		resources: [
			"sealedsecrets/status",
		]
		verbs: [
			"update",
		]
	}, {
		apiGroups: [
			"",
		]
		resources: [
			"secrets",
		]
		verbs: [
			"get",
			"create",
			"update",
			"delete",
		]
	}, {
		apiGroups: [
			"",
		]
		resources: [
			"events",
		]
		verbs: [
			"create",
			"patch",
		]
	}]
}]
