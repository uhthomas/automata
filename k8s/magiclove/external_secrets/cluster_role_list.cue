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
		resources: ["secretstores", "clustersecretstores", "externalsecrets", "clusterexternalsecrets", "pushsecrets", "clusterpushsecrets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["external-secrets.io"]
		resources: ["externalsecrets", "externalsecrets/status", "externalsecrets/finalizers", "secretstores", "secretstores/status", "secretstores/finalizers", "clustersecretstores", "clustersecretstores/status", "clustersecretstores/finalizers", "clusterexternalsecrets", "clusterexternalsecrets/status", "clusterexternalsecrets/finalizers", "pushsecrets", "pushsecrets/status", "pushsecrets/finalizers", "clusterpushsecrets", "clusterpushsecrets/status", "clusterpushsecrets/finalizers"]
		verbs: ["get", "update", "patch"]
	}, {
		apiGroups: ["generators.external-secrets.io"]
		resources: ["generatorstates"]
		verbs: [
			"get", "list", "watch", "create", "update", "patch", "delete", "deletecollection",
		]
	}, {
		apiGroups: ["generators.external-secrets.io"]
		resources: ["acraccesstokens", "cloudsmithaccesstokens", "clustergenerators", "ecrauthorizationtokens", "fakes", "gcraccesstokens", "githubaccesstokens", "quayaccesstokens", "passwords", "sshkeys", "stssessiontokens", "uuids", "vaultdynamicsecrets", "webhooks", "grafanas", "mfas"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["serviceaccounts", "namespaces"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["namespaces"]
		verbs: ["update", "patch"]
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
		resources: ["externalsecrets", "pushsecrets"]
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
		resources: ["externalsecrets", "secretstores", "clustersecretstores", "pushsecrets", "clusterpushsecrets"]
		verbs: ["get", "watch", "list"]
	}, {
		apiGroups: ["generators.external-secrets.io"]
		resources: ["acraccesstokens", "cloudsmithaccesstokens", "clustergenerators", "ecrauthorizationtokens", "fakes", "gcraccesstokens", "githubaccesstokens", "quayaccesstokens", "passwords", "sshkeys", "vaultdynamicsecrets", "webhooks", "grafanas", "generatorstates", "mfas", "uuids"]
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
		resources: ["externalsecrets", "secretstores", "clustersecretstores", "pushsecrets", "clusterpushsecrets"]
		verbs: ["create", "delete", "deletecollection", "patch", "update"]
	}, {
		apiGroups: ["generators.external-secrets.io"]
		resources: ["acraccesstokens", "cloudsmithaccesstokens", "clustergenerators", "ecrauthorizationtokens", "fakes", "gcraccesstokens", "githubaccesstokens", "quayaccesstokens", "passwords", "sshkeys", "vaultdynamicsecrets", "webhooks", "grafanas", "generatorstates", "mfas", "uuids"]
		verbs: ["create", "delete", "deletecollection", "patch", "update"]
	}]
}, {
	metadata: {
		name: "external-secrets-servicebindings"
		labels: "servicebinding.io/controller": "true"
	}
	rules: [{
		apiGroups: ["external-secrets.io"]
		resources: ["externalsecrets", "pushsecrets"]
		verbs: ["get", "list", "watch"]
	}]
}]
