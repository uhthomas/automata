package redlib

import externalsecretsv1beta1 "github.com/external-secrets/external-secrets/apis/externalsecrets/v1beta1"

#ExternalSecretList: externalsecretsv1beta1.#ExternalSecretList & {
	apiVersion: "external-secrets.io/v1"
	kind:       "ExternalSecretList"
	items: [...{
		apiVersion: "external-secrets.io/v1"
		kind:       "ExternalSecret"
	}]
}

#ExternalSecretList: items: [{
	spec: {
		secretStoreRef: {
			name: "onepassword"
			kind: "ClusterSecretStore"
		}
		target: template: metadata: {
			annotations: {}
			labels: {}
		}
		dataFrom: [{
			extract: {
				key:      "redlib-proxy-config"
				property: "config"
			}
		}]
	}
}]
