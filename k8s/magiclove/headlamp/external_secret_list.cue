package headlamp

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
			name: #Name
			kind: "SecretStore"
		}
		target: name: #OIDCSecretName
		refreshInterval: "1m"
		data: [{
			secretKey: "client-secret"
			remoteRef: {
				key:      "headlamp-kanidm-oauth2-credentials"
				property: "CLIENT_SECRET"
			}
		}]
	}
}]
