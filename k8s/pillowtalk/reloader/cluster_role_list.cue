package reloader

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
        rules: [{
		apiGroups: [
			"",
		]
		resources: [
			"secrets",
			"configmaps",
		]
		verbs: [
			"list",
			"get",
			"watch",
		]
	}, {
		apiGroups: [
			"apps",
		]
		resources: [
			"deployments",
			"daemonsets",
			"statefulsets",
		]
		verbs: [
			"list",
			"get",
			"update",
			"patch",
		]
	}, {
		apiGroups: [
			"extensions",
		]
		resources: [
			"deployments",
			"daemonsets",
		]
		verbs: [
			"list",
			"get",
			"update",
			"patch",
		]
	}]
}]
