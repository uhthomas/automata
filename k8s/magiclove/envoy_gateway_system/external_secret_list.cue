package envoy_gateway_system

import corev1 "k8s.io/api/core/v1"

#ExternalSecretList: corev1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "external-secrets.io/v1"
		kind:       "ExternalSecret"
	}]
}

#ExternalSecretList: items: [{
	metadata: name: "envoy-oidc-hmac"
	spec: {
		refreshInterval: "0"
		target: template: {
			metadata: {
				annotations: {}
				labels: {}
			}
			engineVersion: "v2"
			data: "hmac-secret": "{{ .password }}"
		}
		dataFrom: [{
			sourceRef: generatorRef: {
				apiVersion: "generators.external-secrets.io/v1alpha1"
				kind:       "Password"
				name:       "envoy-oidc-hmac"
			}
		}]
	}
}]
