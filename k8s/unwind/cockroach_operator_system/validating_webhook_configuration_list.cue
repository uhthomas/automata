package cockroach_operator_system

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
	metadata: name: "cockroach-operator-validating-webhook-configuration"
	webhooks: [{
		name: "vcrdbcluster.kb.io"
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "cockroach-operator-webhook-service"
			namespace: #Namespace
			path:      "/validate-crdb-cockroachlabs-com-v1alpha1-crdbcluster"
		}
		failurePolicy: admissionregistrationv1.#Fail
		rules: [{
			apiGroups: ["crdb.cockroachlabs.com"]
			apiVersions: ["v1alpha1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["crdbclusters"]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
	}]
}]
