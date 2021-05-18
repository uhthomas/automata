package node_exporter

import rbacv1 "k8s.io/api/rbac/v1"

roleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

roleList: items: [{
	rules: [{
		apiGroups: [
			"extensions",
		]
		resourceNames: [
			"prometheus-node-exporter",
		]
		resources: [
			"podsecuritypolicies",
		]
		verbs: [
			"use",
		]
	}]
}]
