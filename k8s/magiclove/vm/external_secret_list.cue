package vm

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
	metadata: name: "\(#Name)-discord-webhook-url"
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
				key:      "vm-discord-webhook-url"
				property: "webhook-url"
			}
		}]
	}
}, {
	metadata: name: "\(#Name)-pushover"
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
			secretKey: "user-key"
			remoteRef: {
				key:      "vm-pushover"
				property: "user-key"
			}
		}, {
			secretKey: "token"
			remoteRef: {
				key:      "vm-pushover"
				property: "token"
			}
		}]
	}
}]
