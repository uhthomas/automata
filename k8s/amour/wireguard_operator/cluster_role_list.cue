package wireguard_operator

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
		resources: ["configmaps"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["services"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["pods"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["vpn.wireguard-operator.io"]
		resources: ["wireguardpeers"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["vpn.wireguard-operator.io"]
		resources: ["wireguardpeers/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["vpn.wireguard-operator.io"]
		resources: ["wireguardpeers/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["vpn.wireguard-operator.io"]
		resources: ["wireguards"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["vpn.wireguard-operator.io"]
		resources: ["wireguards/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["vpn.wireguard-operator.io"]
		resources: ["wireguards/status"]
		verbs: ["get", "patch", "update"]
	}]
}, {
	metadata: name: "\(#Name)-proxy"
	rules: [{
		apiGroups: ["authentication.k8s.io"]
		resources: ["tokenreviews"]
		verbs: ["create"]
	}, {
		apiGroups: ["authorization.k8s.io"]
		resources: ["subjectaccessreviews"]
		verbs: ["create"]
	}]
}, {
	metadata: name: "\(#Name)-metrics-reader"
	rules: [{
		nonResourceURLs: ["/metrics"]
		verbs: ["get"]
	}]
}]
