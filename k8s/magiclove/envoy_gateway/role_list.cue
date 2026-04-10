package envoy_gateway

import rbacv1 "k8s.io/api/rbac/v1"

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
		apiGroups: [""]
		resources: ["serviceaccounts", "services", "configmaps"]
		verbs: ["create", "get", "list", "delete", "deletecollection", "patch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments", "daemonsets"]
		verbs: ["create", "get", "delete", "deletecollection", "patch"]
	}, {
		apiGroups: ["autoscaling", "policy"]
		resources: ["horizontalpodautoscalers", "poddisruptionbudgets"]
		verbs: ["create", "get", "list", "delete", "deletecollection", "patch"]
	}, {
		apiGroups: ["certificates.k8s.io"]
		resources: ["clustertrustbundles"]
		verbs: ["list", "get", "watch"]
	}]
}, {
	metadata: name: "\(#Name)-leader-election"
	rules: [{
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: ["create", "patch"]
	}]
}]
