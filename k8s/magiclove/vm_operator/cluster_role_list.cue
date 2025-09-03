package vm_operator

import (
	rbacv1 "k8s.io/api/rbac/v1"
	"k8s.io/api/core/v1"
)

#ClusterRoleList: rbacv1.#ClusterRoleList & {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleList"
	items: [...{
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
	}]
}

#ClusterRoleList: items: [{
	rules: [{
		nonResourceURLs: ["/metrics", "/metrics/resources", "/metrics/slis"]
		verbs: ["get", "watch", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps", "configmaps/finalizers", "endpoints", "events", "persistentvolumeclaims", "persistentvolumeclaims/finalizers", "pods/eviction", "secrets", "secrets/finalizers", "services", "services/finalizers", "serviceaccounts", "serviceaccounts/finalizers"]
		verbs: ["*"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps/status", "pods", "nodes", "nodes/proxy", "nodes/metrics", "namespaces"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments", "deployments/finalizers", "statefulsets", "statefulsets/finalizers", "daemonsets", "daemonsets/finalizers", "replicasets", "statefulsets", "statefulsets/finalizers", "statefulsets/status"]
		verbs: ["*"]
	}, {
		apiGroups: ["monitoring.coreos.com"]
		resources: ["*"]
		verbs: ["*"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["clusterrolebindings", "clusterrolebindings/finalizers", "clusterroles", "clusterroles/finalizers", "roles", "rolebindings"]
		verbs: ["*"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: ["list", "get", "watch"]
	}, {
		apiGroups: ["policy"]
		resources: ["poddisruptionbudgets", "poddisruptionbudgets/finalizers"]
		verbs: ["*"]
	}, {
		apiGroups: ["route.openshift.io", "image.openshift.io"]
		resources: ["routers/metrics", "registry/metrics"]
		verbs: ["get"]
	}, {
		apiGroups: ["autoscaling"]
		resources: ["horizontalpodautoscalers"]
		verbs: ["*"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses", "ingresses/finalizers"]
		verbs: ["*"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["get", "list"]
	}, {
		apiGroups: ["discovery.k8s.io"]
		resources: ["endpointslices"]
		verbs: ["list", "watch", "get"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: [
			"vlagents",
			"vlagents/finalizers",
			"vlagents/status",
			"vlogs",
			"vlogs/finalizers",
			"vlogs/status",
			"vlsingles",
			"vlsingles/finalizers",
			"vlsingles/status",
			"vlclusters",
			"vlclusters/finalizers",
			"vlclusters/status",
			"vmagents",
			"vmagents/finalizers",
			"vmagents/status",
			"vmalertmanagerconfigs",
			"vmalertmanagerconfigs/finalizers",
			"vmalertmanagerconfigs/status",
			"vmalertmanagers",
			"vmalertmanagers/finalizers",
			"vmalertmanagers/status",
			"vmalerts",
			"vmalerts/finalizers",
			"vmalerts/status",
			"vmauths",
			"vmauths/finalizers",
			"vmauths/status",
			"vmclusters",
			"vmclusters/finalizers",
			"vmclusters/status",
			"vmnodescrapes",
			"vmnodescrapes/finalizers",
			"vmnodescrapes/status",
			"vmpodscrapes",
			"vmpodscrapes/finalizers",
			"vmpodscrapes/status",
			"vmprobes",
			"vmprobes/finalizers",
			"vmprobes/status",
			"vmrules",
			"vmrules/finalizers",
			"vmrules/status",
			"vmscrapeconfigs",
			"vmscrapeconfigs/finalizers",
			"vmscrapeconfigs/status",
			"vmservicescrapes",
			"vmservicescrapes/finalizers",
			"vmservicescrapes/status",
			"vmsingles",
			"vmsingles/finalizers",
			"vmsingles/status",
			"vmstaticscrapes",
			"vmstaticscrapes/finalizers",
			"vmstaticscrapes/status",
			"vmusers",
			"vmusers/finalizers",
			"vmusers/status",
			"vmanomalies",
			"vmanomalies/finalizers",
			"vmanomalies/status",
		]
		verbs: ["*"]
	}]
}]
