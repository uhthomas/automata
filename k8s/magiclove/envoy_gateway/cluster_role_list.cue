package envoy_gateway

import rbacv1 "k8s.io/api/rbac/v1"

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
		apiGroups: [""]
		resources: ["nodes", "namespaces"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["gateway.networking.k8s.io"]
		resources: ["gatewayclasses"]
		verbs: ["get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["gateway.networking.k8s.io"]
		resources: ["gatewayclasses/status"]
		verbs: ["update"]
	}, {
		apiGroups: ["multicluster.x-k8s.io"]
		resources: ["serviceimports"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["configmaps", "secrets", "services"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments", "daemonsets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["discovery.k8s.io"]
		resources: ["endpointslices"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["gateway.envoyproxy.io"]
		resources: ["envoyproxies", "envoypatchpolicies", "clienttrafficpolicies", "backendtrafficpolicies", "securitypolicies", "envoyextensionpolicies", "backends", "httproutefilters"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["gateway.envoyproxy.io"]
		resources: ["envoypatchpolicies/status", "clienttrafficpolicies/status", "backendtrafficpolicies/status", "securitypolicies/status", "envoyextensionpolicies/status", "backends/status"]
		verbs: ["update"]
	}, {
		apiGroups: ["gateway.networking.k8s.io"]
		resources: ["gateways", "grpcroutes", "httproutes", "referencegrants", "tcproutes", "tlsroutes", "udproutes", "backendtlspolicies"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["gateway.networking.k8s.io"]
		resources: ["gateways/status", "grpcroutes/status", "httproutes/status", "tcproutes/status", "tlsroutes/status", "udproutes/status", "backendtlspolicies/status"]
		verbs: ["update"]
	}, {
		apiGroups: [""]
		resources: ["pods", "pods/binding"]
		verbs: ["get", "list", "patch", "update", "watch"]
	}]
}]
