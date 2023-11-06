package external_secrets

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
	metadata: name: "external-secrets-controller"
	rules: [{
		apiGroups: ["external-secrets.io"]
		resources: ["secretstores", "clustersecretstores", "externalsecrets", "clusterexternalsecrets", "pushsecrets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["external-secrets.io"]
		resources: ["externalsecrets", "externalsecrets/status", "externalsecrets/finalizers", "secretstores", "secretstores/status", "secretstores/finalizers", "clustersecretstores", "clustersecretstores/status", "clustersecretstores/finalizers", "clusterexternalsecrets", "clusterexternalsecrets/status", "clusterexternalsecrets/finalizers", "pushsecrets", "pushsecrets/status", "pushsecrets/finalizers"]
		verbs: ["update", "patch"]
	}, {
		apiGroups: ["generators.external-secrets.io"]
		resources: ["acraccesstokens", "ecrauthorizationtokens", "fakes", "gcraccesstokens", "passwords", "vaultdynamicsecrets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts", "namespaces"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["configmaps"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["secrets"]
		verbs: ["get", "list", "watch", "create", "update", "delete", "patch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts/token"]
		verbs: ["create"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "patch"]
	}, {
		apiGroups: ["external-secrets.io"]
		resources: ["externalsecrets"]
		verbs: ["create", "update", "delete"]
	}]
}, {
	metadata: {
		name: "external-secrets-view"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
			"rbac.authorization.k8s.io/aggregate-to-view":  "true"
		}
	}
	rules: [{
		apiGroups: ["external-secrets.io"]
		resources: ["externalsecrets", "secretstores", "clustersecretstores", "pushsecrets"]
		verbs: ["get", "watch", "list"]
	}, {
		apiGroups: ["generators.external-secrets.io"]
		resources: ["acraccesstokens", "ecrauthorizationtokens", "fakes", "gcraccesstokens", "passwords", "vaultdynamicsecrets"]
		verbs: ["get", "watch", "list"]
	}]
}, {
	metadata: {
		name: "external-secrets-edit"
		labels: {
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
		}
	}
	rules: [{
		apiGroups: ["external-secrets.io"]
		resources: ["externalsecrets", "secretstores", "clustersecretstores", "pushsecrets"]
		verbs: ["create", "delete", "deletecollection", "patch", "update"]
	}, {
		apiGroups: ["generators.external-secrets.io"]
		resources: ["acraccesstokens", "ecrauthorizationtokens", "fakes", "gcraccesstokens", "passwords", "vaultdynamicsecrets"]
		verbs: ["create", "delete", "deletecollection", "patch", "update"]
	}]
}, {
	metadata: {
		name: "external-secrets-servicebindings"
		labels: "servicebinding.io/controller": "true"
	}
	rules: [{
		apiGroups: ["external-secrets.io"]
		resources: ["externalsecrets"]
		verbs: ["get", "list", "watch"]
	}]
}]
