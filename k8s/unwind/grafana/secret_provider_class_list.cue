package grafana

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
			secretName: #Name
			type:       v1.#SecretTypeOpaque
			data: [{
				key:        "admin-user"
				objectName: "admin-user"
			}, {
				key:        "admin-password"
				objectName: "admin-password"
			}]
		}]
		parameters: {
			roleName:     "grafana-admin-read"
			vaultAddress: "http://vault.vault:8200"
			objects:      yaml.Marshal([{
				secretPath: "secret/data/grafana-admin"
				objectName: "admin-user"
				secretKey:  "username"
			}, {
				secretPath: "secret/data/grafana-admin"
				objectName: "admin-password"
				secretKey:  "password"
			}])
		}
	}
}]
