package postgres_operator

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
	metadata: labels: "postgres-operator.crunchydata.com/control-plane": #Name
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["configmaps", "persistentvolumeclaims", "secrets", "services"]
		verbs: ["create", "delete", "get", "list", "patch", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["endpoints"]
		verbs: ["create", "delete", "deletecollection", "get", "list", "patch", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["endpoints/restricted", "pods/exec"]
		verbs: ["create"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["pods"]
		verbs: ["delete", "get", "list", "patch", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts"]
		verbs: ["create", "get", "list", "patch", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments", "statefulsets"]
		verbs: ["create", "delete", "get", "list", "patch", "watch"]
	}, {
		apiGroups: ["batch"]
		resources: ["cronjobs", "jobs"]
		verbs: ["create", "delete", "get", "list", "patch", "watch"]
	}, {
		apiGroups: ["policy"]
		resources: ["poddisruptionbudgets"]
		verbs: ["create", "delete", "get", "list", "patch", "watch"]
	}, {
		apiGroups: ["postgres-operator.crunchydata.com"]
		resources: ["postgresclusters"]
		verbs: ["get", "list", "patch", "watch"]
	}, {
		apiGroups: ["postgres-operator.crunchydata.com"]
		resources: ["postgresclusters/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["postgres-operator.crunchydata.com"]
		resources: ["postgresclusters/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["rolebindings", "roles"]
		verbs: ["create", "get", "list", "patch", "watch"]
	}]
}, {
	metadata: {
		name: "\(#Name)-upgrade"
		labels: "postgres-operator.crunchydata.com/control-plane": "\(#Name)-upgrade"
	}
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["endpoints"]
		verbs: ["delete", "get", "list", "watch"]
	}, {
		apiGroups: ["apps"]
		resources: ["statefulsets"]
		verbs: ["list", "watch"]
	}, {
		apiGroups: ["batch"]
		resources: ["jobs"]
		verbs: ["create", "delete", "list", "patch", "watch"]
	}, {
		apiGroups: ["postgres-operator.crunchydata.com"]
		resources: ["pgupgrades"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["postgres-operator.crunchydata.com"]
		resources: ["pgupgrades/finalizers"]
		verbs: ["patch", "update"]
	}, {
		apiGroups: ["postgres-operator.crunchydata.com"]
		resources: ["pgupgrades/status"]
		verbs: ["get", "patch"]
	}, {
		apiGroups: ["postgres-operator.crunchydata.com"]
		resources: ["postgresclusters"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["postgres-operator.crunchydata.com"]
		resources: ["postgresclusters/status"]
		verbs: ["patch"]
	}]
}]
