package tailscale

import (
	"encoding/yaml"

	"k8s.io/api/core/v1"
)

#SecretProviderClassList: v1.#List & {
	apiVersion: "secrets-store.csi.x-k8s.io/v1"
	kind:       "SecretProviderClassList"
	items: [...{
		apiVersion: "secrets-store.csi.x-k8s.io/v1"
		kind:       "SecretProviderClass"
	}]
}

#SecretProviderClassList: items: [{
	spec: {
		provider: "vault"
		secretObjects: [{
			secretName: "operator-oauth"
			type:       v1.#SecretTypeOpaque
			data: [{
				key:        "client_id"
				objectName: key
			}, {
				key:        "client_secret"
				objectName: key
			}]
		}]
		parameters: {
			roleName:     "tailscale-operator"
			vaultAddress: "http://vault.vault:8200"
			objects: yaml.Marshal([{
				secretPath: "secret/data/kubernetes/unwind/\(#Namespace)/operator-oauth"
				objectName: "client_id"
				secretKey:  objectName
			}, {
				secretPath: "secret/data/kubernetes/unwind/\(#Namespace)/operator-oauth"
				objectName: "client_secret"
				secretKey:  objectName
			}])
		}
	}
}]
