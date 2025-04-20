package cnpg_system

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
	metadata: name: "cnpg-mutating-webhook-configuration"
	webhooks: [{
		name: "mbackup.cnpg.io"
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
			path:      "/mutate-postgresql-cnpg-io-v1-backup"
		}
	}, {
		name: "mcluster.cnpg.io"
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
			path:      "/mutate-postgresql-cnpg-io-v1-cluster"
		}
	}, {
		name: "mscheduledbackup.cnpg.io"
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
			namespace: #Namespace
			path:      "/mutate-postgresql-cnpg-io-v1-scheduledbackup"
		}
	}]
}]
