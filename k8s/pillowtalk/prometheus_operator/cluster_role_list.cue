package prometheus_operator

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
			"monitoring.coreos.com",
		]
		resources: [
			"alertmanagers",
			"alertmanagers/finalizers",
			"alertmanagerconfigs",
			"prometheuses",
			"prometheuses/finalizers",
			"thanosrulers",
			"thanosrulers/finalizers",
			"servicemonitors",
			"podmonitors",
			"probes",
			"prometheusrules",
		]
		verbs: [
			"*",
		]
	}, {
		apiGroups: ["apps"]
		resources: [
			"statefulsets",
		]
		verbs: [
			"*",
		]
	}, {
		apiGroups: [""]
		resources: [
			"configmaps",
			"secrets",
		]
		verbs: [
			"*",
		]
	}, {
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"list",
			"delete",
		]
	}, {
		apiGroups: [""]
		resources: [
			"services",
			"services/finalizers",
			"endpoints",
		]
		verbs: [
			"get",
			"create",
			"update",
			"delete",
		]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: [
			"namespaces",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"networking.k8s.io",
		]
		resources: [
			"ingresses",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}]
