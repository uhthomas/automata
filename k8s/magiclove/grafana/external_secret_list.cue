package grafana

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
	spec: {
		refreshPolicy: "OnChange"
		target: {
			immutable: true
			template: {
				metadata: {
					annotations: {}
					labels: {}
				}
				engineVersion: "v2"
				data: {
					username: "admin"
					password: "{{ .password }}"
				}
			}
		}
		dataFrom: [{
			sourceRef: generatorRef: {
				apiVersion: "generators.external-secrets.io/v1alpha1"
				kind:       "Password"
				name:       #Name
			}
		}]
	}
}]
