package tesladump

import appsv1 "k8s.io/api/apps/v1"

deployment: appsv1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "tesladump"
	spec: {
		replicas:                1
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: type: "Recreate"
		minReadySeconds: 1
		selector: matchLabels: app: "tesladump"
		template: {
			metadata: labels: app: "tesladump"
			spec: {
				containers: [{
					name:            "tesladump"
					image:           "ghcr.io/uhthomas/tesladump:v0.1.10"
					imagePullPolicy: "IfNotPresent"
					ports: [{
						name:          "http"
						containerPort: 80
					}]
					env: [{
						name: "MONGO_URI"
						valueFrom: secretKeyRef: {
							name: "tesladump"
							key:  "mongo-uri"
						}
					}]
					args: [
						"--mongo-uri=$(MONGO_URI)",
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
						name:      "tesladump"
						mountPath: "/etc/secret"
						readOnly:  true
					}]
				}]
				volumes: [{
					name: "tesladump"
					secret: {
						secretName: "tesladump"
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