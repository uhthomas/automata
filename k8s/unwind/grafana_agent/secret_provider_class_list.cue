package grafana_agent

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
	metadata: name: "\(#Name)-grafana-cloud"
	spec: {
		provider: "vault"
		secretObjects: [{
			secretName: metadata.name
			type:       v1.#SecretTypeOpaque
			data: [{
				key:        "logs-username"
				objectName: "logs-username"
			}, {
				key:        "logs-password"
				objectName: "logs-password"
			}, {
				key:        "metrics-username"
				objectName: "metrics-username"
			}, {
				key:        "metrics-password"
				objectName: "metrics-password"
			}]
		}]
		parameters: {
			roleName:     "grafana-agent-grafana-cloud-read"
			vaultAddress: "http://vault.vault:8200"
			objects:      yaml.Marshal([{
				secretPath: "secret/data/kubernetes/unwind/grafana-agent/grafana-cloud-logs"
				objectName: "logs-username"
				secretKey:  "username"
			}, {
				secretPath: "secret/data/kubernetes/unwind/grafana-agent/grafana-cloud-logs"
				objectName: "logs-password"
				secretKey:  "password"
			}, {
				secretPath: "secret/data/kubernetes/unwind/grafana-agent/grafana-cloud-metrics"
				objectName: "metrics-username"
				secretKey:  "username"
			}, {
				secretPath: "secret/data/kubernetes/unwind/grafana-agent/grafana-cloud-metrics"
				objectName: "metrics-password"
				secretKey:  "password"
			}])
		}
	}
}]
