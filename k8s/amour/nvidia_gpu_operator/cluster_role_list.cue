package nvidia_gpu_operator

import (
	"k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
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
		apiGroups: ["config.openshift.io"]
		resources: ["proxies"]
		verbs: ["get"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["roles", "rolebindings", "clusterroles", "clusterrolebindings"]
		verbs: ["*"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods", "services", "endpoints", "persistentvolumeclaims", "events", "configmaps", "secrets", "serviceaccounts", "nodes"]
		verbs: ["*"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["namespaces"]
		verbs: ["get", "list", "create", "watch", "update", "patch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments", "daemonsets", "replicasets", "statefulsets"]
		verbs: ["*"]
	}, {
		apiGroups: ["apps"]
		resources: ["controllerrevisions"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["monitoring.coreos.com"]
		resources: ["servicemonitors", "prometheusrules"]
		verbs: ["get", "list", "create", "watch", "update", "delete"]
	}, {
		apiGroups: ["nvidia.com"]
		resources: ["*"]
		verbs: ["*"]
	}, {
		apiGroups: ["scheduling.k8s.io"]
		resources: ["priorityclasses"]
		verbs: ["get", "list", "watch", "create"]
	}, {
		apiGroups: ["security.openshift.io"]
		resources: ["securitycontextconstraints"]
		verbs: ["*"]
	}, {
		apiGroups: ["policy"]
		resources: ["podsecuritypolicies"]
		verbs: ["use"]
		resourceNames: ["gpu-operator-restricted"]
	}, {
		apiGroups: ["policy"]
		resources: ["podsecuritypolicies"]
		verbs: ["create", "get", "update", "list", "delete"]
	}, {
		apiGroups: ["config.openshift.io"]
		resources: ["clusterversions"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName, "coordination.k8s.io"]
		resources: ["configmaps", "leases"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: ["node.k8s.io"]
		resources: ["runtimeclasses"]
		verbs: ["get", "list", "create", "update", "watch", "delete"]
	}, {
		apiGroups: ["image.openshift.io"]
		resources: ["imagestreams"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods", "pods/eviction"]
		verbs: ["get", "list", "watch", "create", "delete", "update", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get", "list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: ["get", "list", "watch", "update", "patch", "create"]
	}]
}]
