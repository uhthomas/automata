package cert_manager

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
	metadata: name: "cloudflare-api-token"
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
			secretKey: "api-token"
			remoteRef: {
				key:      "cert-manager cloudflare api token"
				property: "credential"
			}
		}]
	}
}]
