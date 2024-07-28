package onepassword_connect

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#DeploymentList: appsv1.#DeploymentList & {
	apiVersion: "apps/v1"
	kind:       "DeploymentList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}]
}

#DeploymentList: items: [{
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "shared-data"
					emptyDir: {}
				}, {
					name: "credentials"
					secret: secretName: "onepassword-credentials"
				}]
				containers: [{
					name:  "connect-api"
					image: "1password/connect-api:1.7.2@sha256:6aa94cf713f99c0fa58c12ffdd1b160404b4c13a7f501a73a791aa84b608c5a1"
					env: [{
						name: "OP_SESSION"
						valueFrom: secretKeyRef: {
							name: "onepassword-credentials"
							key:  "1password-credentials.json"
						}
					}, {
						name:  "OP_BUS_PORT"
						value: "11220"
					}, {
						name:  "OP_BUS_PEERS"
						value: "localhost:11221"
					}, {
						name:  "OP_HTTP_PORT"
						value: "8080"
					}, {
						name:  "OP_LOG_LEVEL"
						value: "info"
					}]
					ports: [{
						name:          "api-http"
						containerPort: 8080
					}]
					volumeMounts: [{
						name:      "shared-data"
						mountPath: "/home/opuser/.op/data"
					}]

					let probe = v1.#Probe & {
						httpGet: port: "api-http"
						initialDelaySeconds: 15
					}

					livenessProbe: probe & {
						httpGet: path: "/heartbeat"
						failureThreshold: 3
						periodSeconds:    30
					}
					readinessProbe: probe & {
						httpGet: path: "/health"
					}

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						// readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}, {
					name:  "connect-sync"
					image: "1password/connect-sync:1.7.2@sha256:fe527ed9d81f193d8dfbba4140d61f9e8c8dceb0966b3009259087504e5ff79c"
					env: [{
						name:  "OP_HTTP_PORT"
						value: "8081"
					}, {
						name: "OP_SESSION"
						valueFrom: secretKeyRef: {
							name: "onepassword-credentials"
							key:  "1password-credentials.json"
						}
					}, {
						name:  "OP_BUS_PORT"
						value: "11221"
					}, {
						name:  "OP_BUS_PEERS"
						value: "localhost:11220"
					}, {
						name:  "OP_LOG_LEVEL"
						value: "info"
					}]
					ports: [{
						name:          "sync-http"
						containerPort: 8081
					}]
					volumeMounts: [{
						name:      "shared-data"
						mountPath: "/home/opuser/.op/data"
					}]

					let probe = v1.#Probe & {
						httpGet: port: "sync-http"
						initialDelaySeconds: 15
					}

					livenessProbe: probe & {
						httpGet: path: "/heartbeat"
						failureThreshold: 3
						periodSeconds:    30
					}
					readinessProbe: probe & {
						httpGet: path: "/health"
					}

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						// readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				securityContext: {
					// runAsUser:  1000
					// runAsGroup: 1000
					// runAsNonRoot: true
					// fsGroup: 1000
					// https://github.com/1Password/connect/issues/76
					// runAsUser:    1000
					// runAsGroup:   3000
					// runAsNonRoot: true
					// fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}]
