package tesla_exporter

import (
	"k8s.io/api/core/v1"
	appsv1 "k8s.io/api/apps/v1"
)

deploymentList: appsv1.#DeploymentList & {
	apiVersion: "apps/v1"
	kind:       "DeploymentList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}]
}

deploymentList: items: [{
	spec: {
		replicas:                1
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: type: "Recreate"
		minReadySeconds: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "tesla-exporter"
			"app.kubernetes.io/instance":  "tesla-exporter"
			"app.kubernetes.io/component": "tesla-exporter"
		}
		template: {
			metadata: {
				annotations: "prometheus.io/scrape": "true"
				labels: {
					"app.kubernetes.io/name":      "tesla-exporter"
					"app.kubernetes.io/instance":  "tesla-exporter"
					"app.kubernetes.io/component": "tesla-exporter"
				}
			}
			spec: {
				containers: [{
					name:  "tesla-exporter"
					image: "ghcr.io/uhthomas/tesla_exporter:v0.7.2@sha256:d3f069386a4cd564d77447e64a1727baeb25bb039fba18edf627680374426edf"
					ports: [{
						containerPort: 80
					}]
					args: [
						"--oauth2-config-path=/etc/secret/oauth2_config.json",
						"--oauth2-token-path=/etc/secret/oauth2_token.json",
						"--expire=5m",
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
					imagePullPolicy: v1.#PullIfNotPresent
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
}]
