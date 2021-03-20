package loki

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

deployment: [...appsv1.#Deployment]

deployment: [{
	apiVersion: "apps/v1"
	kind:       "Deployment"
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
					image: "grafana/loki:2.2.0@sha256:83649aa867ffdc353cea17e9465bfc26b1f172c78c19ac906400b5028576c3f3"
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
