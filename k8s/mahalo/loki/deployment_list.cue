package loki

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
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
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: type: "Recreate"
		minReadySeconds: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "loki"
		}
		replicas: 1
		template: {
			metadata: {
				annotations: "prometheus.io/scrape": "true"
				labels: {
					"app.kubernetes.io/name":      "loki"
					"app.kubernetes.io/instance":  "loki"
					"app.kubernetes.io/component": "loki"
				}
			}
			spec: {
				containers: [{
					name:  "loki"
					image: "grafana/loki:2.3.0@sha256:f63e49ea86a8c180d065b37547525eb8ccc3d51548ee64882d52bf92a485e481"
					ports: [{
						name:          "http-metrics"
						containerPort: 3100
					}]
					args: [
						"--config.file=/etc/config/loki.yaml",
					]
					resources: {
						requests: {
							memory: "64Mi"
							cpu:    "50m"
						}
						limits: {
							memory: "256Mi"
							cpu:    "400m"
						}
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/config"
						readOnly:  true
					}, {
						name:      "storage"
						mountPath: "/data"
					}]
					livenessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 45
						periodSeconds:       10
						failureThreshold:    3
					}
					readinessProbe: {
						httpGet: {
							path: "/ready"
							port: "http-metrics"
						}
						initialDelaySeconds: 45
						periodSeconds:       10
						failureThreshold:    3
					}
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				volumes: [{
					name: "config"
					configMap: name: "loki"
				}, {
					name: "storage"
					persistentVolumeClaim: claimName: "loki"
				}]
				securityContext: {
					fsGroup:      65534
					runAsGroup:   65534
					runAsNonRoot: true
					runAsUser:    65534
				}
			}
		}
	}
}]
