package tesla_exporter

import appsv1 "k8s.io/api/apps/v1"

deployment: appsv1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "tesla-exporter"
	spec: {
		replicas:                1
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: type: "Recreate"
		minReadySeconds: 1
		selector: matchLabels: app: "tesla-exporter"
		template: {
			metadata: {
				annotations: {
					"prometheus.io/scrape": "true"
					"prometheus.io/port":   "80"
				}
				labels: app: "tesla-exporter"
			}
			spec: {
				containers: [{
					name: "tesla-exporter"
					// v0.6.11
					image:           "ghcr.io/uhthomas/tesla_exporter@sha256:47b0381f63c170da503c3aac0f4db5efac03c2a4e7bf9bb685e2c55fc168a3eb"
					imagePullPolicy: "IfNotPresent"
					ports: [{
						containerPort: 80
					}]
					args: [
						"--oauth2-config-path=/etc/secret/oauth2_config.json",
						"--oauth2-token-path=/etc/secret/oauth2_token.json",
					]
					resources: {
						requests: {
							memory: "8Mi"
							cpu:    "10m"
						}
						limits: {
							memory: "16Mi"
							cpu:    "20m"
						}
					}
					volumeMounts: [{
						name:      "tesla-exporter"
						mountPath: "/etc/secret"
						readOnly:  true
					}]
				}]
				volumes: [{
					name: "tesla-exporter"
					secret: {
						secretName: "tesla-exporter"
						items: [{
							key:  "oauth2_config.json"
							path: "oauth2_config.json"
						}, {
							key:  "oauth2_token.json"
							path: "oauth2_token.json"
						}]
					}
				}]
			}
		}
	}
}
