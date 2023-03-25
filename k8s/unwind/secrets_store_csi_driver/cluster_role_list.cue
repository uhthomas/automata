package secrets_store_csi_driver

import (
	"k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
	storagev1 "k8s.io/api/storage/v1"
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
	metadata: name: "secretproviderrotation-role"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: [v1.#ResourceSecrets]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: {
		name: "secretproviderclasses-admin-role"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
		}
	}
	rules: [{
		apiGroups: ["secrets-store.csi.x-k8s.io"]
		resources: ["secretproviderclasses"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}]
}, {
	metadata: {
		name: "secretproviderclasses-viewer-role"
		labels: "rbac.authorization.k8s.io/aggregate-to-view": "true"
	}
	rules: [{
		apiGroups: ["secrets-store.csi.x-k8s.io"]
		resources: ["secretproviderclasses"]
		verbs: ["get", "list", "watch"]
	}]
}, {
	metadata: name: "secretprovidersyncing-role"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: [v1.#ResourceSecrets]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}]
}, {
	metadata: name: "secretproviderclasses-role"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: [v1.#ResourcePods]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["secrets-store.csi.x-k8s.io"]
		resources: ["secretproviderclasses"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["secrets-store.csi.x-k8s.io"]
		resources: ["secretproviderclasspodstatuses"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["secrets-store.csi.x-k8s.io"]
		resources: ["secretproviderclasspodstatuses/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: [storagev1.#GroupName]
		resourceNames: ["secrets-store.csi.k8s.io"]
		resources: ["csidrivers"]
		verbs: ["get", "list", "watch"]
	}]
}]
