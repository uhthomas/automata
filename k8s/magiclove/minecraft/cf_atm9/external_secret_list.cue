package cf_atm9

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
	spec: {
		secretStoreRef: {
			name: "onepassword"
			kind: "ClusterSecretStore"
		}
		target: template: metadata: {
			annotations: {}
			labels: {}
		}
		data: [{
			secretKey: "cf-api-key"
			remoteRef: {
				key:      "curseforge api key"
				property: "password"
			}
		}]
	}
}]
