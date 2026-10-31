package depot

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
				username: "smbuser"
				password: "{{ .password }}"
			}
		}
		// Preserve the generated password across pod restarts and reconciles.
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
