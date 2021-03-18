package node_exporter

import rbacv1 "k8s.io/api/rbac/v1"

role: [...rbacv1.#Role]

role: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		name: "node-exporter"
		labels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/version":   "1.2.2"
			"app.kubernetes.io/component": "node-exporter"
		}
	}
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
