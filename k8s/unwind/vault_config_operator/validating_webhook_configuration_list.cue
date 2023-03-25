package vault_config_operator

import admissionregistrationv1 "k8s.io/api/admissionregistration/v1"

#ValidatingWebhookConfigurationList: admissionregistrationv1.#ValidatingWebhookConfigurationList & {
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "ValidatingWebhookConfigurationList"
	items: [...{
		apiVersion: "admissionregistration.k8s.io/v1"
		kind:       "ValidatingWebhookConfiguration"
	}]
}

#ValidatingWebhookConfigurationList: items: [{
	metadata: {
		name: "vault-config-operator-validating-webhook-configuration"
		annotations: "cert-manager.io/inject-ca-from": "\(#Namespace)/serving-cert"
	}
	webhooks: [{
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-authenginemount"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vauthenginemount.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["authenginemounts"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-databasesecretengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vdatabasesecretengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create, admissionregistrationv1.#Update]
			resources: ["databasesecretengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-databasesecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vdatabasesecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["databasesecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-databasesecretenginestaticrole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vdatabasesecretenginestaticrole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create, admissionregistrationv1.#Update]
			resources: ["databasesecretenginestaticroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-githubsecretengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vgithubsecretengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create, admissionregistrationv1.#Update]
			resources: ["githubsecretengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-githubsecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vgithubsecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["githubsecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-jwtoidcauthengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vjwtoidcauthengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["jwtoidcauthengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-jwtoidcauthenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vjwtoidcauthenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["jwtoidcauthengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-kubernetesauthengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vkubernetesauthengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["kubernetesauthengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-kubernetesauthenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vkubernetesauthenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create, admissionregistrationv1.#Update]
			resources: ["kubernetesauthengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-kubernetessecretengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vkubernetessecretengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["kubernetessecretengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-kubernetessecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vkubernetessecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["kubernetessecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-ldapauthengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vldapauthengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["ldapauthengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-ldapauthenginegroup"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vldapauthenginegroup.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["ldapauthenginegroups"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-pkisecretengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vpkisecretengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["pkisecretengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-pkisecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vpkisecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["pkisecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-quaysecretengineconfig"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vquaysecretengineconfig.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create, admissionregistrationv1.#Update]
			resources: ["quaysecretengineconfigs"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-quaysecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vquaysecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create, admissionregistrationv1.#Update]
			resources: ["quaysecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-quaysecretenginestaticrole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vquaysecretenginestaticrole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create, admissionregistrationv1.#Update]
			resources: ["quaysecretenginestaticroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-rabbitmqsecretenginerole"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vrabbitmqsecretenginerole.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["rabbitmqsecretengineroles"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-randomsecret"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vrandomsecret.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create, admissionregistrationv1.#Update]
			resources: ["randomsecrets"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-secretenginemount"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vsecretenginemount.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Update]
			resources: ["secretenginemounts"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}, {
		admissionReviewVersions: ["v1", "v1beta1"]
		clientConfig: service: {
			name:      "vault-config-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-redhatcop-redhat-io-v1alpha1-vaultsecret"
		}
		failurePolicy: admissionregistrationv1.#Fail
		name:          "vvaultsecret.kb.io"
		rules: [{
			apiGroups: ["redhatcop.redhat.io"]
			apiVersions: ["v1alpha1"]
			operations: [admissionregistrationv1.#Create, admissionregistrationv1.#Update]
			resources: ["vaultsecrets"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}]
}]
