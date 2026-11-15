package livesync

import "k8s.io/api/core/v1"

#ExternalSecretList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "external-secrets.io/v1"
		kind:       "ExternalSecret"
	}]
}

#ExternalSecretList: items: [{
	spec: {
		target: template: {
			engineVersion: "v2"
			data: {
				username: "admin"
				password: "{{ .password }}"
			}
		}
		refreshPolicy: "CreatedOnce"
		dataFrom: [{
			sourceRef: generatorRef: {
				apiVersion: "generators.external-secrets.io/v1alpha1"
				kind:       "Password"
				name:       #Name
			}
		}]
	}
}]
