package kipp

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
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: rollingUpdate: maxUnavailable: 1
		minReadySeconds: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "kipp"
			"app.kubernetes.io/instance":  "kipp"
			"app.kubernetes.io/component": "kipp"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "kipp"
				"app.kubernetes.io/instance":  "kipp"
				"app.kubernetes.io/component": "kipp"
			}
			spec: {
				containers: [{
					name:  "nginx"
					image: "nginx:1.21.3@sha256:7250923ba3543110040462388756ef099331822c6172a050b12c7a38361ea46f"
					ports: [{
						name:          "http"
						containerPort: 80
					}]
					resources: {
						requests: {
							memory: "2Mi"
							cpu:    "2m"
						}
						limits: {
							memory: "8Mi"
							cpu:    "5m"
						}
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/usr/share/nginx/html"
						readOnly:  true
					}]
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: "http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
					readinessProbe: {
						httpGet: {
							path: "/healthz"
							port: "http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				volumes: [{
					name: "config"
					configMap: name: "kipp"
				}]
			}
		}
	}
}]
