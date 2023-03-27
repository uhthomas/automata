package prowlarr

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
	metadata: name: "\(#Name)-tailscale"
	spec: {
		provider: "vault"
		secretObjects: [{
			secretName: metadata.name
			type:       v1.#SecretTypeOpaque
			data: [{
				key:        "authkey"
				objectName: "authkey"
			}]
		}]
		parameters: {
			roleName:     "media-prowlarr-tailscale-read"
			vaultAddress: "http://vault.vault:8200"
			objects:      yaml.Marshal([{
				secretPath: "secret/data/kubernetes/unwind/media/prowlarr-tailscale-authkey"
				objectName: "authkey"
				secretKey:  "authkey"
			}])
		}
	}
}]
