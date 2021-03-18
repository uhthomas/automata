package node_exporter

import rbacv1 "k8s.io/api/rbac/v1"

role_binding: [...rbacv1.#RoleBinding]

role_binding: [{
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		name: "node-exporter"
		labels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/version":   "1.2.2"
			"app.kubernetes.io/component": "node-exporter"
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "node-exporter"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "node-exporter"
		namespace: "prometheus"
	}]
}]
