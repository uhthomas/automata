package frigate

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
			secretKey: "mqtt-password"
			remoteRef: {
				key:      "mosquitto-frigate"
				property: "password"
			}
		}, {
			secretKey: "doorbell-secret"
			remoteRef: {
				key:      "frigate-doorbell"
				property: "secret"
			}
		}, {
			secretKey: "wjbc516a003968-password"
			remoteRef: {
				key:      "frigate-wjbc516a003968"
				property: "password"
			}
		}]
	}
}]
