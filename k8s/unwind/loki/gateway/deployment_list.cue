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
					image: "nginxinc/nginx-unprivileged:1.25.1-alpine3.17-slim@sha256:b430e078ce037cb8e2b21ec172317a9c6b50c42c66dbbe36c8a63572f4adaab5"
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
