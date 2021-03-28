package cert_manager

import admissionregistrationv1 "k8s.io/api/admissionregistration/v1"

validatingWebhookConfigurationList: admissionregistrationv1.#ValidatingWebhookConfigurationList & {
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "ValidatingWebhookConfigurationList"
	items: [...{
		apiVersion: "admissionregistration.k8s.io/v1"
		kind:       "ValidatingWebhookConfiguration"
	}]
}

validatingWebhookConfigurationList: items: [{
	metadata: {
		name: "cert-manager-webhook"
		annotations: "cert-manager.io/inject-ca-from-secret": "cert-manager/cert-manager-webhook-ca"
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/component": "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "webhook"
		}
	}
	webhooks: [{
		admissionReviewVersions: [
			"v1",
			"v1beta1",
		]
		clientConfig: service: {
			name:      "cert-manager-webhook"
			namespace: "cert-manager"
			path:      "/validate"
		}
		failurePolicy: "Fail"
		name:          "webhook.cert-manager.io"
		namespaceSelector: matchExpressions: [{
			key:      "cert-manager.io/disable-validation"
			operator: "NotIn"
			values: [
				"true",
			]
		}, {
			key:      "name"
			operator: "NotIn"
			values: [
				"cert-manager",
			]
		}]
		rules: [{
			apiGroups: [
				"cert-manager.io",
				"acme.cert-manager.io",
			]
			apiVersions: ["*"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: [
				"*/*",
			]
		}]
		sideEffects:    "None"
		timeoutSeconds: 10
	}]
}]
