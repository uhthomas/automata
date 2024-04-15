package emqx_exporter

import (
	"encoding/yaml"

	externalsecretsv1beta1 "github.com/external-secrets/external-secrets/apis/externalsecrets/v1beta1"
)

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
		target: template: {
			engineVersion: "v2"
			metadata: {
				annotations: {}
				labels: {}
			}
			data: "config.yaml": yaml.Marshal({
				metrics: {
					target:     "emqx.emqx"
					api_key:    "{{ .key }}"
					api_secret: "{{ .secret }}"
				}
				probes: [{
					target:   "emqx.emqx:1883"
					username: "emqx-exporter"
					password: "{{ .mqttPassword }}"
				}]
			})
		}
		data: [{
			secretKey: "key"
			remoteRef: {
				key:      "emqx-exporter"
				property: "api key"
			}
		}, {
			secretKey: "secret"
			remoteRef: {
				key:      "emqx-exporter"
				property: "api secret key"
			}
		}, {
			secretKey: "mqttPassword"
			remoteRef: {
				key:      "emqx-exporter"
				property: "mqtt password"
			}
		}]
	}
}]
