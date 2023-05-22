package dragonfly_operator_system

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
	metadata: name: "\(#Name)-manager"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["services"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["statefulsets"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["dragonflydb.io"]
		resources: ["dragonflies"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["dragonflydb.io"]
		resources: ["dragonflies/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["dragonflydb.io"]
		resources: ["dragonflies/status"]
		verbs: ["get", "patch", "update"]
	}]
}, {
	metadata: {
		name: "\(#Name)-metrics-reader"
		labels: "app.kubernetes.io/component": "kube-rbac-proxy"
	}
	rules: [{
		nonResourceURLs: ["/metrics"]
		verbs: ["get"]
	}]
}, {
	metadata: {
		name: "\(#Name)-proxy"
		labels: "app.kubernetes.io/component": "kube-rbac-proxy"
	}
	rules: [{
		apiGroups: ["authentication.k8s.io"]
		resources: ["tokenreviews"]
		verbs: ["create"]
	}, {
		apiGroups: ["authorization.k8s.io"]
		resources: ["subjectaccessreviews"]
		verbs: ["create"]
	}]
}]
