package node_exporter

import rbacv1 "k8s.io/api/rbac/v1"

role: [...rbacv1.#Role]

role: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
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
