package cnpg_system

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
	metadata: name: "cnpg-validating-webhook-configuration"
	webhooks: [{
		name: "vbackup.cnpg.io"
		rules: [{
			apiGroups: ["postgresql.cnpg.io"]
			apiVersions: ["v1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["backups"]
		}]
		admissionReviewVersions: ["v1"]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		clientConfig: service: {
			name:      "cnpg-webhook-service"
			namespace: "cnpg-system"
			path:      "/validate-postgresql-cnpg-io-v1-backup"
		}
	}, {
		name: "vcluster.cnpg.io"
		rules: [{
			apiGroups: ["postgresql.cnpg.io"]
			apiVersions: ["v1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["clusters"]
		}]
		admissionReviewVersions: ["v1"]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		clientConfig: service: {
			name:      "cnpg-webhook-service"
			namespace: "cnpg-system"
			path:      "/validate-postgresql-cnpg-io-v1-cluster"
		}
	}, {
		name: "vpooler.cnpg.io"
		rules: [{
			apiGroups: ["postgresql.cnpg.io"]
			apiVersions: ["v1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["poolers"]
		}]
		admissionReviewVersions: ["v1"]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		clientConfig: service: {
			name:      "cnpg-webhook-service"
			namespace: "cnpg-system"
			path:      "/validate-postgresql-cnpg-io-v1-pooler"
		}
	}, {
		name: "vscheduledbackup.cnpg.io"
		rules: [{
			apiGroups: ["postgresql.cnpg.io"]
			apiVersions: ["v1"]
			operations: ["CREATE", "UPDATE"]
			resources: ["scheduledbackups"]
		}]
		admissionReviewVersions: ["v1"]
		failurePolicy: admissionregistrationv1.#Fail
		sideEffects:   admissionregistrationv1.#SideEffectClassNone
		clientConfig: service: {
			name:      "cnpg-webhook-service"
			namespace: "cnpg-system"
			path:      "/validate-postgresql-cnpg-io-v1-scheduledbackup"
		}
	}]
}]
