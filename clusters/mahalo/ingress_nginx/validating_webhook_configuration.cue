package ingress_nginx

import admissionregistrationv1 "k8s.io/api/admissionregistration/v1"

validating_webhook_configuration: [...admissionregistrationv1.#ValidatingWebhookConfiguration]

validating_webhook_configuration: [{
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "ValidatingWebhookConfiguration"
	metadata: {
		name: "ingress-nginx-admission"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
			"app.kubernetes.io/component": "admission-webhook"
		}
	}
	webhooks: [{
		name:        "validate.nginx.ingress.kubernetes.io"
		matchPolicy: "Equivalent"
		rules: [{
			apiGroups: [
				"networking.k8s.io",
			]
			apiVersions: [
				"v1beta1",
			]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: [
				"ingresses",
			]
		}]
		failurePolicy: "Fail"
		sideEffects:   "None"
		admissionReviewVersions: [
			"v1",
			"v1beta1",
		]
		clientConfig: service: {
			namespace: "ingress-nginx"
			name:      "ingress-nginx-controller-admission"
			path:      "/networking/v1beta1/ingresses"
		}
	}]
}]
