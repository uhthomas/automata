package cert_manager

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
		name: "cert-manager-webhook"
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "webhook"
		}
		annotations: "cert-manager.io/inject-ca-from-secret": "cert-manager/cert-manager-webhook-ca"
	}
	webhooks: [{
		name: "webhook.cert-manager.io"
		rules: [{
			apiGroups: ["cert-manager.io"]
			apiVersions: ["v1"]
			operations: ["CREATE"]
			resources: ["certificaterequests"]
		}]
		admissionReviewVersions: ["v1"]
		// This webhook only accepts v1 cert-manager resources.
		// Equivalent matchPolicy ensures that non-v1 resource requests are sent to
		// this webhook (after the resources have been converted to v1).
		matchPolicy:    admissionregistrationv1.#Equivalent
		timeoutSeconds: 30
		failurePolicy:  admissionregistrationv1.#Fail
		sideEffects:    admissionregistrationv1.#SideEffectClassNone
		clientConfig: service: {
			name:      "cert-manager-webhook"
			namespace: #Namespace
			path:      "/mutate"
		}
	}]
}]
