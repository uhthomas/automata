package cloudflared

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
	metadata: annotations: "reloader.stakater.com/auto": "true"
	spec: {
		selector: matchLabels: app: "cloudflared"
		replicas: 3
		template: {
			metadata: labels: app: "cloudflared"
			spec: {
				containers: [{
					name:  "cloudflared"
					image: "cloudflare/cloudflared:2022.10.0-amd64@sha256:db58bb38c3cd1c206999c2133d1355d86a0be40510685b9d21d87b0c0a8662e3"
					args: [
						"tunnel",
						"--config",
						"/etc/cloudflared/config/config.yaml",
						"run",
					]
					livenessProbe: {
						httpGet: {
							// Cloudflared has a /ready endpoint which returns 200 if and only if
							// it has an active connection to the edge.
							path: "/ready"
							port: 2000
						}
						failureThreshold:    1
						initialDelaySeconds: 10
						periodSeconds:       10
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/cloudflared/config"
						readOnly:  true
					}, {
						name:      "creds"
						mountPath: "/etc/cloudflared/creds"
						readOnly:  true
					}]
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				volumes: [{
					name: "creds"
					secret: secretName: "tunnel-credentials"
				}, {
					name: "config"
					configMap: {
						name: "cloudflared"
						items: [{
							key:  "config.yaml"
							path: "config.yaml"
						}]
					}
				}]
			}
		}
	}
}]
