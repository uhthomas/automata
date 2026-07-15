package headlamp

import externalsecretsv1beta1 "github.com/external-secrets/external-secrets/apis/externalsecrets/v1beta1"

#SecretStoreList: externalsecretsv1beta1.#SecretStoreList & {
	apiVersion: "external-secrets.io/v1"
	kind:       "SecretStoreList"
	items: [...{
		apiVersion: "external-secrets.io/v1"
		kind:       "SecretStore"
	}]
}

#SecretStoreList: items: [{
	spec: provider: kubernetes: {
		server: caProvider: {
			type: externalsecretsv1beta1.#CAProviderTypeConfigMap
			name: "kube-root-ca.crt"
			key:  "ca.crt"
		}
		auth: serviceAccount: name: #OIDCSecretServiceAccountName
		remoteNamespace: #Namespace
	}
}]
