package reloader

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
		replicas:             1
		revisionHistoryLimit: 2
		selector: matchLabels: {
			"app.kubernetes.io/name":      "reloader"
			"app.kubernetes.io/instance":  "reloader"
			"app.kubernetes.io/component": "reloader"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "reloader"
				"app.kubernetes.io/instance":  "reloader"
				"app.kubernetes.io/component": "reloader"
			}
			spec: {
				containers: [{
					image:           "stakater/reloader:v0.0.90@sha256:9cb9dd7cc2332e074354bb6d44c215a7f1b2ce5d98ecafa5d09ea17e423897f0"
					imagePullPolicy: v1.#PullIfNotPresent
					name:            "reloader"
					ports: [{
						name:          "http"
						containerPort: 9090
					}]
					livenessProbe: httpGet: {
						path: "/metrics"
						port: "http"
					}
					readinessProbe: httpGet: {
						path: "/metrics"
						port: "http"
					}
				}]
				securityContext: {
					runAsNonRoot: true
					runAsUser:    65534
				}
				serviceAccountName: "reloader"
			}
		}
	}
}]
