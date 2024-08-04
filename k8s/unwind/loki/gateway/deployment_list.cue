package gateway

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
		selector: matchLabels: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/component": #Component
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "loki"
				"app.kubernetes.io/component": #Component
			}
			spec: {
				volumes: [{
					name: "config"
					configMap: name: #Name
				}, {
					name: "tmp"
					emptyDir: {}
				}, {
					name: "docker-entrypoint-d-override"
					emptyDir: {}
				}]
				containers: [{
					name:  "nginx"
					image: "nginxinc/nginx-unprivileged:1.23.4-alpine3.17-slim@sha256:d517dd550cadf9b38bab37ee1a2beb85b91c74b0a92e921bbc90cb3bd8e14f7c"
					ports: [{
						name:          "http"
						containerPort: 8080
					}]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/nginx"
					}, {
						name:      "tmp"
						mountPath: "/tmp"
					}, {
						name:      "docker-entrypoint-d-override"
						mountPath: "/docker-entrypoint.d"
					}]
					readinessProbe: {
						httpGet: {
							path: "/"
							port: "http"
						}
						initialDelaySeconds: 15
					}
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: "loki"
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				affinity: podAntiAffinity: requiredDuringSchedulingIgnoredDuringExecution: [{
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      "loki"
						"app.kubernetes.io/component": #Component
					}
					topologyKey: v1.#LabelHostname
				}]
			}
		}
	}
}]
