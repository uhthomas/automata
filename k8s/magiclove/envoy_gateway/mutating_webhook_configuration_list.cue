package envoy_gateway

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
	metadata: name: "envoy-gateway-topology-injector"
	webhooks: [{
		name: "topology.webhook.gateway.envoyproxy.io"
		clientConfig: service: {
			name:      #Name
			namespace: #Namespace
			path:      "/inject-pod-topology"
			port:      9443
		}
		rules: [{
			operations: ["CREATE"]
			apiGroups: [""]
			apiVersions: ["v1"]
			resources: ["pods/binding"]
		}]
		failurePolicy: admissionregistrationv1.#Ignore
		namespaceSelector: matchExpressions: [{
			key:      "kubernetes.io/metadata.name"
			operator: "In"
			values: [#Namespace]
		}]
		sideEffects: admissionregistrationv1.#SideEffectClassNone
		admissionReviewVersions: ["v1"]
	}]
}]
