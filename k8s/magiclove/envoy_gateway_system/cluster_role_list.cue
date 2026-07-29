package envoy_gateway_system

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
		resources: ["gateways", "listenersets", "grpcroutes", "httproutes", "referencegrants", "tcproutes", "tlsroutes", "udproutes", "backendtlspolicies"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["gateway.networking.k8s.io"]
		resources: ["gateways/status", "listenersets/status", "grpcroutes/status", "httproutes/status", "tcproutes/status", "tlsroutes/status", "udproutes/status", "backendtlspolicies/status"]
		verbs: ["update"]
	}, {
		apiGroups: [""]
		resources: ["pods", "pods/binding"]
		verbs: ["get", "list", "patch", "update", "watch"]
	}]
}, {
	metadata: name: "\(#Name)-cluster-infra-manager"
	rules: [{
		apiGroups: [""]
		resources: ["serviceaccounts", "services", "configmaps"]
		verbs: ["create", "get", "list", "delete", "deletecollection", "patch", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments", "daemonsets"]
		verbs: ["create", "get", "list", "delete", "deletecollection", "patch", "watch"]
	}, {
		apiGroups: ["autoscaling", "policy"]
		resources: ["horizontalpodautoscalers", "poddisruptionbudgets"]
		verbs: ["create", "get", "list", "delete", "deletecollection", "patch", "watch"]
	}, {
		apiGroups: ["certificates.k8s.io"]
		resources: ["clustertrustbundles"]
		verbs: ["list", "get", "watch"]
	}, {
		apiGroups: ["authentication.k8s.io"]
		resources: ["tokenreviews"]
		verbs: ["create"]
	}]
}]
