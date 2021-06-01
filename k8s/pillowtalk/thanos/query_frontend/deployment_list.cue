package query_frontend

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
		strategy: rollingUpdate: maxUnavailable: 1
		minReadySeconds: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "thanos"
			"app.kubernetes.io/instance":  "thanos"
			"app.kubernetes.io/component": "query-frontend"
		}
		template: {
			metadata: {
				annotations: "prometheus.io/scrape": "true"
				labels: {
					"app.kubernetes.io/name":      "thanos"
					"app.kubernetes.io/instance":  "thanos"
					"app.kubernetes.io/component": "query-frontend"
				}
			}
			spec: containers: [{
				name:  "query-frontend"
				image: "quay.io/thanos/thanos:v0.18.0@sha256:b94171aed499b2f1f81b6d3d385e0eeeca885044c59cef28ce6a9a9e8a827217"
				ports: [{
					name:          "http"
					containerPort: 80
				}]
				args: [
					"query-frontend",
					"--http-address=:80",
					"--http-grace-period=5s",
					"--query-frontend.downstream-url=http://query",
				]
				livenessProbe: {
					httpGet: {
						path: "/-/healthy"
						port: "http"
					}
					initialDelaySeconds: 5
					periodSeconds:       3
				}
				readinessProbe: {
					httpGet: {
						path: "/-/ready"
						port: "http"
					}
					initialDelaySeconds: 5
					periodSeconds:       3
				}
				resources: {
					requests: {
						memory: "512Mi"
						cpu:    "1000m"
					}
					limits: {
						memory: "1Gi"
						cpu:    "2000m"
					}
				}
				imagePullPolicy: v1.#PullIfNotPresent
			}]
		}
	}
}]
