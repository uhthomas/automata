package vault_config_operator

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
	metadata: name: "vault-config-operator-manager-role"
	rules: [{
		apiGroups: [v1.#GroupName]
		resources: ["events"]
		verbs: ["create", "get", "list", "patch", "watch"]
	}, {
		apiGroups: [v1.#GroupName]
		resources: ["namespaces"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: [""]
		resources: ["serviceaccounts/token"]
		verbs: ["create", "get", "list", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["authenginemounts"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["authenginemounts/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["authenginemounts/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["databasesecretengineconfigs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["databasesecretengineconfigs", "randomsecrets"]
		verbs: ["get", "list", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["databasesecretengineconfigs/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["databasesecretengineconfigs/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["databasesecretengineroles"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["databasesecretengineroles/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["databasesecretengineroles/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["databasesecretenginestaticroles"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["databasesecretenginestaticroles/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["databasesecretenginestaticroles/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["githubsecretengineconfigs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["githubsecretengineconfigs/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["githubsecretengineconfigs/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["githubsecretengineroles"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["githubsecretengineroles/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["githubsecretengineroles/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["jwtoidcauthengineconfigs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["jwtoidcauthengineconfigs/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["jwtoidcauthengineconfigs/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["jwtoidcauthengineroles"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["jwtoidcauthengineroles/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["jwtoidcauthengineroles/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetesauthengineconfigs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetesauthengineconfigs/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetesauthengineconfigs/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetesauthengineroles"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetesauthengineroles/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetesauthengineroles/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetessecretengineconfigs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetessecretengineconfigs/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetessecretengineconfigs/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetessecretengineroles"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetessecretengineroles/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["kubernetessecretengineroles/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["ldapauthengineconfigs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["ldapauthengineconfigs/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["ldapauthengineconfigs/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["ldapauthenginegroups"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["ldapauthenginegroups/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["ldapauthenginegroups/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["passwordpolicies"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["passwordpolicies/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["passwordpolicies/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["pkisecretengineconfigs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["pkisecretengineconfigs/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["pkisecretengineconfigs/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["pkisecretengineroles"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["pkisecretengineroles/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["pkisecretengineroles/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["policies"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["policies/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["policies/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["quaysecretengineconfigs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["quaysecretengineconfigs/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["quaysecretengineconfigs/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["quaysecretengineroles"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["quaysecretengineroles/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["quaysecretengineroles/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["quaysecretenginestaticroles"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["quaysecretenginestaticroles/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["quaysecretenginestaticroles/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["rabbitmqsecretengineconfigs"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["rabbitmqsecretengineconfigs/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["rabbitmqsecretengineroles"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["rabbitmqsecretengineroles/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["rabbitmqsecretengineroles/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["randomsecrets"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["randomsecrets/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["randomsecrets/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["secretenginemounts"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["secretenginemounts/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["secretenginemounts/status"]
		verbs: ["get", "patch", "update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["vaultsecrets"]
		verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["vaultsecrets/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["redhatcop.redhat.io"]
		resources: ["vaultsecrets/status"]
		verbs: ["get", "patch", "update"]
	}]
}, {
	metadata: name: "vault-config-operator-metrics-reader"
	rules: [{
		nonResourceURLs: ["/metrics"]
		verbs: ["get"]
	}]
}, {
	metadata: name: "vault-config-operator-proxy-role"
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
