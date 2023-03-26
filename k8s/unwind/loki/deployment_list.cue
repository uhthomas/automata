package loki

import (
	appsv1 "k8s.io/api/apps/v1"
	// "k8s.io/api/core/v1"
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
	metadata: {
		name: "loki-gateway"
		labels: "app.kubernetes.io/component": "gateway"
	}
	spec: {
		replicas: 1
		strategy: type: "RollingUpdate"
		revisionHistoryLimit: 10
		selector: matchLabels: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/instance":  #Name
			"app.kubernetes.io/component": "gateway"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      #Name
				"app.kubernetes.io/instance":  #Name
				"app.kubernetes.io/component": "gateway"
			}
			spec: {
				serviceAccountName: #Name
				enableServiceLinks: true

				securityContext: {
					fsGroup:      101
					runAsGroup:   101
					runAsNonRoot: true
					runAsUser:    101
				}
				terminationGracePeriodSeconds: 30
				containers: [{
					name:            "nginx"
					image:           "docker.io/nginxinc/nginx-unprivileged:1.19-alpine"
					imagePullPolicy: "IfNotPresent"
					ports: [{
						name:          "http"
						containerPort: 8080
						protocol:      "TCP"
					}]
					readinessProbe: {
						httpGet: {
							path: "/"
							port: "http"
						}
						initialDelaySeconds: 15
						timeoutSeconds:      1
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: [
							"ALL",
						]
						readOnlyRootFilesystem: true
					}
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
					resources: {}
				}]

				affinity: podAntiAffinity: requiredDuringSchedulingIgnoredDuringExecution: [{
					labelSelector: matchLabels: {
						"app.kubernetes.io/name":      "loki"
						"app.kubernetes.io/instance":  "loki"
						"app.kubernetes.io/component": "gateway"
					}
					topologyKey: "kubernetes.io/hostname"
				}]

				volumes: [{
					name: "config"
					configMap: name: "loki-gateway"
				}, {
					name: "tmp"
					emptyDir: {}
				}, {
					name: "docker-entrypoint-d-override"
					emptyDir: {}
				}]
			}
		}
	}
}]
