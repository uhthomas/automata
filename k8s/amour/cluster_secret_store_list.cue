package amour

import externalsecretsv1beta1 "github.com/external-secrets/external-secrets/apis/externalsecrets/v1beta1"

#ClusterSecretStoreList: externalsecretsv1beta1.#ClusterSecretStoreList & {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ClusterSecretStoreList"
	items: [...{
		apiVersion: "external-secrets.io/v1beta1"
		kind:       "ClusterSecretStore"
	}]
}

#ClusterSecretStoreList: items: [{
	metadata: name: "onepassword"
	spec: provider: onepassword: {
		connectHost: "http://onepassword-connect.onepassword-connect:8080"
		vaults: amour: 1
		auth: secretRef: connectTokenSecretRef: {
			name:      "onepassword-connect-token"
			namespace: "onepassword-connect"
			key:       "token"
		}
	}
}]
