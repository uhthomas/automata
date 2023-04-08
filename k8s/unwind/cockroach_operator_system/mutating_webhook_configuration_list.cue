package cockroach_operator_system

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
	metadata: name: "cockroach-operator-mutating-webhook-configuration"
	webhooks: [{
		name: "mcrdbcluster.kb.io"
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "cockroach-operator-webhook-service"
			namespace: #Namespace
			path:      "/mutate-crdb-cockroachlabs-com-v1alpha1-crdbcluster"
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
