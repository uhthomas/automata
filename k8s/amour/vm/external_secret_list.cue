package vm

import externalsecretsv1beta1 "github.com/external-secrets/external-secrets/apis/externalsecrets/v1beta1"

#ExternalSecretList: externalsecretsv1beta1.#ExternalSecretList & {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecretList"
	items: [...{
		apiVersion: "external-secrets.io/v1beta1"
		kind:       "ExternalSecret"
	}]
}

#ExternalSecretList: items: [{
	metadata: name: "vmalertmanager-vm-config"
	spec: {
		secretStoreRef: {
			name: "onepassword"
			kind: "ClusterSecretStore"
		}
		target: {
			creationPolicy: externalsecretsv1beta1.#CreatePolicyMerge
			template: metadata: {
				annotations: {}
				labels: {}
			}
		}
		dataFrom: [{
			extract: {
				key:      "vmalertmanager-vm-config"
				property: "alertmanager.yaml"
			}
		}]
	}
}]
