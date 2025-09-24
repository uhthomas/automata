package immich

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
	metadata: name: "immich-pg-db-credentials"
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
				key:      "immich-pg-db-credentials"
				property: "username"
			}
		}, {
			extract: {
				key:      "immich-pg-db-credentials"
				property: "password"
			}
		}]
	}
}]
