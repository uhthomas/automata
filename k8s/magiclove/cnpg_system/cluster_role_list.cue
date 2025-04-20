package cnpg_system

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
	metadata: name: "cnpg-manager"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["configmaps", "secrets", "services"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps/status", "secrets/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["nodes"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["persistentvolumeclaims", "pods", "pods/exec"]
		verbs: ["create", "delete", "get", "list", "patch", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods/status"]
		verbs: ["get"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts"]
		verbs: ["create", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["admissionregistration.k8s.io"]
		resources: ["mutatingwebhookconfigurations", "validatingwebhookconfigurations"]
		verbs: ["get", "patch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["batch"]
		resources: ["jobs"]
		verbs: ["create", "delete", "get", "list", "patch", "watch"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["create", "get", "update"]
	}, {
		apiGroups: ["monitoring.coreos.com"]
		resources: ["podmonitors"]
		verbs: ["create", "delete", "get", "list", "patch", "watch"]
	}, {
		apiGroups: ["policy"]
		resources: ["poddisruptionbudgets"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["backups", "clusters", "databases", "poolers", "publications", "scheduledbackups", "subscriptions"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["backups/status", "databases/status", "publications/status", "scheduledbackups/status", "subscriptions/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["clusterimagecatalogs", "imagecatalogs"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["clusters/finalizers", "poolers/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["clusters/status", "poolers/status"]
		verbs: ["get", "patch", "update", "watch"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["rolebindings", "roles"]
		verbs: ["create", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["snapshot.storage.k8s.io"]
		resources: ["volumesnapshots"]
		verbs: ["create", "get", "list", "patch", "watch"]
	}]
}, {
	metadata: name: "cnpg-database-editor-role"
	rules: [{
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["databases"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["databases/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "cnpg-database-viewer-role"
	rules: [{
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["databases"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["databases/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "cnpg-publication-editor-role"
	rules: [{
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["publications"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["publications/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "cnpg-publication-viewer-role"
	rules: [{
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["publications"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["publications/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "cnpg-subscription-editor-role"
	rules: [{
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["subscriptions"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["subscriptions/status"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "cnpg-subscription-viewer-role"
	rules: [{
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["subscriptions"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["postgresql.cnpg.io"]
		resources: ["subscriptions/status"]
		verbs: ["get"]
	}]
}]
