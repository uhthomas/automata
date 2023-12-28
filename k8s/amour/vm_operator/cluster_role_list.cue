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
		apiGroups: [v1.#GroupName]
		resources: ["configmaps", "configmaps/finalizers"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["endpoints"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["namespaces"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims", "persistentvolumeclaims/finalizers"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets", "secrets/finalizers"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["services", "services/finalizers"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments", "deployments/finalizers"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: ["apps"]
		resources: ["replicasets"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: ["apps"]
		resources: ["statefulsets", "statefulsets/finalizers", "statefulsets/status"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: ["policy"]
		resources: ["poddisruptionbudgets", "poddisruptionbudgets/finalizers"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: ["monitoring.coreos.com"]
		resources: [rbacv1.#ResourceAll]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmagents", "vmagents/finalizers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmagents/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmalertmanagers", "vmalertmanagers/finalizers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmalertmanagers/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmalerts", "vmalerts/finalizers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmalerts/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmclusters", "vmclusters/finalizers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmclusters/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmpodscrapes"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmpodscrapes/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmrules"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmrules/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmservicescrapes"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmservicescrapes/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmprobes"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmprobes/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmsingles", "vmsingles/finalizers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmsingles/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes", "nodes/proxy", "nodes/metrics", "services", "endpoints", "pods", "endpointslices", "configmaps"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["extensions", "extensions", "networking.k8s.io", "networking.k8s.io"]
		resources: ["ingresses"]
		verbs: ["get", "list", "watch", "delete"]
	}, {
		nonResourceURLs: ["/metrics", "/metrics/resources"]
		verbs: ["get", "watch", "list"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["clusterrolebindings", "clusterrolebindings/finalizers", "clusterroles", "clusterroles/finalizers", "roles", "rolebindings"]
		verbs: ["get", "list", "create", "patch", "update", "watch", "delete"]
	}, {
		apiGroups: ["policy"]
		resources: ["podsecuritypolicies", "podsecuritypolicies/finalizers"]
		verbs: ["get", "list", "create", "patch", "update", "use", "watch", "delete"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts", "serviceaccounts/finalizers"]
		verbs: ["get", "list", "create", "watch", "delete", "patch", "update"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmnodescrapes", "vmnodescrapes/finalizers"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmnodescrapes/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmstaticscrapes", "vmnodescrapes/finalizers"]
		verbs: [rbacv1.#VerbAll]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmstaticscrapes/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: ["list", "get", "watch"]
	}, {
		apiGroups: ["route.openshift.io", "image.openshift.io"]
		resources: ["routers/metrics", "registry/metrics"]
		verbs: ["get"]
	}, {
		apiGroups: ["autoscaling"]
		resources: ["horizontalpodautoscalers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmusers", "vmusers/finalizers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmusers/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmauths", "vmauths/finalizers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmauths/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["networking.k8s.io", "extensions"]
		resources: ["ingresses", "ingresses/finalizers"]
		verbs: ["create", "delete", "get", "patch", "update", "watch"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["get", "list"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmalertmanagerconfigs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: ["vmalertmanagerconfigs/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["discovery.k8s.io"]
		resources: ["endpointslices"]
		verbs: ["get", "list", "watch"]
	}]
}]
