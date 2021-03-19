package kube_state_metrics

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
		minReadySeconds:         1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "kube-state-metrics"
			"app.kubernetes.io/instance":  "kube-state-metrics"
			"app.kubernetes.io/component": "kube-state-metrics"
		}
		replicas: 1
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/instance":  "kube-state-metrics"
				"app.kubernetes.io/component": "kube-state-metrics"
			}
			spec: {
				containers: [{
					name:  "kube-state-metrics"
					image: "k8s.gcr.io/kube-state-metrics/kube-state-metrics:v2.0.0-rc.0@sha256:ed886c793c35596c64e45d0bf34dd345bf42caaf246a7e55e160be36bf70c085"
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "telemetry"
						containerPort: 8081
					}]
					resources: {
						requests: {
							memory: "32Mi"
							cpu:    "20m"
						}
						limits: {
							memory: "128Mi"
							cpu:    "50m"
						}
					}
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: "http-metrics"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
						timeoutSeconds:      5
					}
					readinessProbe: {
						httpGet: {
							path: "/"
							port: "telemetry"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
						timeoutSeconds:      5
					}
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				nodeSelector: "kubernetes.io/os": "linux"
				serviceAccountName: "kube-state-metrics"
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
