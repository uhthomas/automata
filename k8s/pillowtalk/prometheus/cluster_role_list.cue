package prometheus

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
		apiGroups: [""]
		resources: [
			"nodes",
			"nodes/metrics",
			"services",
			"endpoints",
			"pods",
		]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: [
			"configmaps",
		]
		verbs: ["get"]
	}, {
		apiGroups: [
			"networking.k8s.io",
		]
		resources: [
			"ingresses",
		]
		verbs: ["get", "list", "watch"]
	}, {
		nonResourceURLs: ["/metrics"]
		verbs: ["get"]
	}]
}]
