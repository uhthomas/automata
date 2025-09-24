package webhook

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
	metadata: annotations: (certmanagerv1.#WantInjectAnnotation): "\(#Namespace)/\(#Name)"
	webhooks: [{
		name: "validate.secretstore.external-secrets.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      #Name
			path:      "/validate-external-secrets-io-v1-secretstore"
		}
		rules: [{
			apiGroups: ["external-secrets.io"]
			apiVersions: ["v1"]
			operations: ["CREATE", "UPDATE", "DELETE"]
			resources: ["secretstores"]
			scope: admissionregistrationv1.#NamespacedScope
		}]
		sideEffects:    admissionregistrationv1.#SideEffectClassNone
		timeoutSeconds: 5
		admissionReviewVersions: ["v1", "v1beta1"]
	}, {
		name: "validate.clustersecretstore.external-secrets.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      #Name
			path:      "/validate-external-secrets-io-v1-clustersecretstore"
		}
		rules: [{
			apiGroups: ["external-secrets.io"]
			apiVersions: ["v1"]
			operations: ["CREATE", "UPDATE", "DELETE"]
			resources: ["clustersecretstores"]
			scope: admissionregistrationv1.#ClusterScope
		}]
		sideEffects:    admissionregistrationv1.#SideEffectClassNone
		timeoutSeconds: 5
		admissionReviewVersions: ["v1", "v1beta1"]
	}, {
		name: "validate.externalsecret.external-secrets.io"
		clientConfig: service: {
			namespace: #Namespace
			name:      #Name
			path:      "/validate-external-secrets-io-v1-externalsecret"
		}
		rules: [{
			apiGroups: ["external-secrets.io"]
			apiVersions: ["v1"]
			operations: ["CREATE", "UPDATE", "DELETE"]
			resources: ["externalsecrets"]
			scope: admissionregistrationv1.#NamespacedScope
		}]
		failurePolicy:  admissionregistrationv1.#Fail
		sideEffects:    admissionregistrationv1.#SideEffectClassNone
		timeoutSeconds: 5
		admissionReviewVersions: ["v1", "v1beta1"]
	}]
}]
