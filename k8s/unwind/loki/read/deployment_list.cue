package read

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
	metadata: labels: "app.kubernetes.io/part-of": "memberlist"
	spec: {
		replicas: 3
		selector: matchLabels: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/component": #Component
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "loki"
				"app.kubernetes.io/component": #Component
				"app.kubernetes.io/part-of":   "memberlist"
			}
			spec: {
				volumes: [{
					name: "tmp"
					emptyDir: {}
				}, {
					name: "data"
					emptyDir: {}
				}, {
					name: "config"
					configMap: name: "loki"
				}, {
					name: "runtime-config"
					configMap: name: "loki-runtime"
				}]
				containers: [{
					name:  "loki"
					image: "grafana/loki:2.8.2@sha256:dc4328febf349d9198ef0f1c893160483fc7b2180d7e31485325f6e702ee73c4"
					args: [
						"-config.expand-env=true",
						"-config.file=/etc/loki/config/config.yaml",
						"-target=read",
						"-legacy-read-mode=false",
						"-common.compactor-grpc-address=loki-backend.loki.svc.cluster.local:9095",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 3100
					}, {
						name:          "grpc"
						containerPort: 9095
					}, {
						name:          "http-memberlist"
						containerPort: 7946
					}]
					envFrom: [{
						configMapRef: name: "loki-bucket"
					}, {
						secretRef: name: "loki-bucket"
					}]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/loki/config"
					}, {
						name:      "runtime-config"
						mountPath: "/etc/loki/runtime-config"
					}, {
						name:      "tmp"
						mountPath: "/tmp"
					}, {
						name:      "data"
						mountPath: "/var/loki"
					}]
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 30
						timeoutSeconds:      1
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
		strategy: rollingUpdate: {
			maxUnavailable: 1
			maxSurge:       0
		}
	}
}]
