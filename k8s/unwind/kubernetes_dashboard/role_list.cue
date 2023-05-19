package kubernetes_dashboard

import (
	"k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
)

#RoleList: rbacv1.#RoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "Role"
	}]
}

#RoleList: items: [{
	rules: [{
		// Allow Dashboard to get, update and delete Dashboard exclusive secrets.
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		resourceNames: ["kubernetes-dashboard-key-holder", "kubernetes-dashboard-certs", "kubernetes-dashboard-csrf"]
		verbs: ["get", "update", "delete"]
	}, {
		// Allow Dashboard to get and update 'kubernetes-dashboard-settings' config map.
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		resourceNames: ["kubernetes-dashboard-settings"]
		verbs: ["get", "update"]
	}, {
		// Allow Dashboard to get metrics.
		apiGroups: [v1.#GroupName]
		resources: ["services"]
		resourceNames: ["heapster", "dashboard-metrics-scraper"]
		verbs: ["proxy"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["services/proxy"]
		resourceNames: ["heapster", "http:heapster:", "https:heapster:", "dashboard-metrics-scraper", "http:dashboard-metrics-scraper"]
		verbs: ["get"]
	}]
}]
