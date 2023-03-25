package vault_config_operator

import admissionregistrationv1 "k8s.io/api/admissionregistration/v1"

#MutatingWebhookConfigurationList: admissionregistrationv1.#MutatingWebhookConfigurationList & {
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "MutatingWebhookConfigurationList"
	items: [...{
		apiVersion: "admissionregistration.k8s.io/v1"
		kind:       "MutatingWebhookConfiguration"
	}]
}

#MutatingWebhookConfigurationList: items: [{
	metadata: {
		name: "vault-config-operator-mutating-webhook-configuration"
		annotations: "cert-manager.io/inject-ca-from": "\(#Namespace)/serving-cert"
	}
	webhooks: [{
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-authenginemount"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mauthenginemount.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["authenginemounts"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-databasesecretengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mdatabasesecretengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["databasesecretengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-databasesecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mdatabasesecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["databasesecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-databasesecretenginestaticrole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mdatabasesecretenginestaticrole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["databasesecretenginestaticroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-githubsecretengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mgithubsecretengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["githubsecretengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-githubsecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mgithubsecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["githubsecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-jwtoidcauthengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mjwtoidcauthengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["jwtoidcauthengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-jwtoidcauthenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mjwtoidcauthenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["jwtoidcauthengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-kubernetesauthengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mkubernetesauthengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["kubernetesauthengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-kubernetesauthenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mkubernetesauthenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["kubernetesauthengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-kubernetessecretengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mkubernetessecretengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["kubernetessecretengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-kubernetessecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mkubernetessecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["kubernetessecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-ldapauthengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mldapauthengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["ldapauthengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-ldapauthenginegroup"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mldapauthenginegroup.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["ldapauthenginegroups"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-passwordpolicy"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mpasswordpolicy.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["passwordpolicies"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-pkisecretengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mpkisecretengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["pkisecretengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-pkisecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mpkisecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["pkisecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-policy"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mpolicy.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["policies"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-quaysecretengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mquaysecretengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["quaysecretengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-quaysecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mquaysecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["quaysecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-quaysecretenginestaticrole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mquaysecretenginestaticrole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["quaysecretenginestaticroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-rabbitmqsecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mrabbitmqsecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["rabbitmqsecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-randomsecret"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mrandomsecret.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["randomsecrets"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-secretenginemount"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "msecretenginemount.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create]
			resources: ["secretenginemounts"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-redhatcop-redhat-io-v1alpha1-vaultsecret"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "mvaultsecret.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create, "UPDATE"]
			resources: ["vaultsecrets"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}]
}]
