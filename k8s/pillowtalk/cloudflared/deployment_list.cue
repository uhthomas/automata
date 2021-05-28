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
	spec: {
		selector: matchLabels: app: "cloudflared"
		replicas: 3 // You could also consider elastic scaling for this deployment
		template: {
			metadata: labels: app: "cloudflared"
			spec: {
				containers: [{
					name:  "cloudflared"
					image: "cloudflare/cloudflared:2021.5.10@sha256:d3774873aaf286a3a3e401f56ad7cf6d014f6a7144b88cac81e7fbee4fc62209"
					args: [
						"tunnel",
						"--config",
						"/etc/cloudflared/config/config.yaml",
						"run",
					]
					// Points cloudflared to the config file, which configures what
					// cloudflared will actually do. This file is created by a ConfigMap
					// below.
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
						// Each tunnel has an associated "credentials file" which authorizes machines
						// to run the tunnel. cloudflared will read this file from its local filesystem,
						// and it'll be stored in a k8s secret.
						name:      "creds"
						mountPath: "/etc/cloudflared/creds"
						readOnly:  true
					}]
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				volumes: [{
					name: "creds"
					secret: {
						// By default, the credentials file will be created under ~/.cloudflared/<tunnel ID>.json
						// when you run `cloudflared tunnel create`. You can move it into a secret by using:
						// ```sh
						// kubectl create secret generic tunnel-credentials \
						// --from-file=credentials.json=/Users/yourusername/.cloudflared/<tunnel ID>.json
						// ```
						secretName: "tunnel-credentials"
					}
				}, {
					// Create a config.yaml file from the ConfigMap below.
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
