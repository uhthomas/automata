package kaniop

import (
	certmanagerv1 "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"
	admissionregistrationv1 "k8s.io/api/admissionregistration/v1"
)

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
		name: "\(#Name)-webhook"
		annotations: (certmanagerv1.#WantInjectAnnotation): "\(#Namespace)/\(#Name)-webhook-root-cert"
	}
	webhooks: [{
		name: "validate-kanidm-group.kaniop.rs"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-kanidm-group"
			port:      8443
		}
		rules: [{
			apiGroups: ["kaniop.rs"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE"]
			resources: ["kanidmgroups"]
		}]
		failurePolicy:  admissionregistrationv1.#Fail
		sideEffects:    admissionregistrationv1.#SideEffectClassNone
		timeoutSeconds: 10
		admissionReviewVersions: ["v1"]
	}, {
		name: "validate-kanidm-person.kaniop.rs"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-kanidm-person"
			port:      8443
		}
		rules: [{
			apiGroups: ["kaniop.rs"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE"]
			resources: ["kanidmpersonsaccounts"]
		}]
		failurePolicy:  admissionregistrationv1.#Fail
		sideEffects:    admissionregistrationv1.#SideEffectClassNone
		timeoutSeconds: 10
		admissionReviewVersions: ["v1"]
	}, {
		name: "validate-kanidm-oauth2.kaniop.rs"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-kanidm-oauth2"
			port:      8443
		}
		rules: [{
			apiGroups: ["kaniop.rs"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE"]
			resources: ["kanidmoauth2clients"]
		}]
		failurePolicy:  admissionregistrationv1.#Fail
		sideEffects:    admissionregistrationv1.#SideEffectClassNone
		timeoutSeconds: 10
		admissionReviewVersions: ["v1"]
	}, {
		name: "validate-kanidm-service-account.kaniop.rs"
		clientConfig: service: {
			namespace: #Namespace
			name:      "\(#Name)-webhook"
			path:      "/validate-kanidm-service-account"
			port:      8443
		}
		rules: [{
			apiGroups: ["kaniop.rs"]
			apiVersions: ["v1beta1"]
			operations: ["CREATE"]
			resources: ["kanidmserviceaccounts"]
		}]
		failurePolicy:  admissionregistrationv1.#Fail
		sideEffects:    admissionregistrationv1.#SideEffectClassNone
		timeoutSeconds: 10
		admissionReviewVersions: ["v1"]
	}]
}]
