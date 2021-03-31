package sealed_secrets

import rbacv1 "k8s.io/api/rbac/v1"

clusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

clusterRoleList: items: [{
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
