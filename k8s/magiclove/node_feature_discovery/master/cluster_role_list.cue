package master

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
		apiGroups: [v1.#GroupName]
		resources: ["nodes", "nodes/status"]
		verbs: ["get", "patch", "update", "list"]
	}, {
		apiGroups: ["nfd.k8s-sigs.io"]
		resources: ["nodefeatures", "nodefeaturerules"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["create"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		resourceNames: ["nfd-master.nfd.kubernetes.io"]
		verbs: ["get", "update"]
	}]
}]
