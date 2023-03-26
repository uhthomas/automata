package recyclarr

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
			secretName: "\(#Name)-api-keys"
			type:       v1.#SecretTypeOpaque
			data: [{
				key:        "radarr-api-key"
				objectName: key
			}, {
				key:        "sonarr-api-key"
				objectName: key
			}]
		}]
		parameters: {
			roleName:     "media-recyclarr-read"
			vaultAddress: "http://vault.vault:8200"
			objects:      yaml.Marshal([{
				secretPath: "secret/data/kubernetes/unwind/media/radarr-api-key"
				objectName: "radarr-api-key"
				secretKey:  "key"
			}, {
				secretPath: "secret/data/kubernetes/unwind/media/sonarr-api-key"
				objectName: "sonarr-api-key"
				secretKey:  "key"
			}])
		}
	}
}]
