package external_dns

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
		resources: ["services", "endpoints", "pods", "namespaces"]
		verbs: ["get", "watch", "list"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: ["get", "watch", "list"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: ["externaldns.k8s.io"]
		resources: ["dnsendpoints"]
		verbs: ["get", "watch", "list"]
	}, {
		apiGroups: ["externaldns.k8s.io"]
		resources: ["dnsendpoints/status"]
		verbs: ["*"]
	}]
	// }, {
	// 	apiGroups: ["gateway.networking.k8s.io"]
	// 	resources: ["httproutes", "grpcroutes", "tlsroutes", "tcproutes", "udproutes"]
	// 	verbs: ["get", "watch", "list"]
	// }]
}]
