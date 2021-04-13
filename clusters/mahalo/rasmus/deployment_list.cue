package rasmus

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
			"app.kubernetes.io/name":      "rasmus"
			"app.kubernetes.io/instance":  "rasmus"
			"app.kubernetes.io/component": "rasmus"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "rasmus"
				"app.kubernetes.io/instance":  "rasmus"
				"app.kubernetes.io/component": "rasmus"
			}
			spec: {
				containers: [{
					name:  "rasmus"
					image: "ghcr.io/uhthomas/rasmus:v0.2.0@sha256:2c8c8c9290249d20cbfe7f7a544629743a39bc5dc6568630ff3940d03e9bcffa"

					ports: [{
						name:          "http"
						containerPort: 8080
					}]
					resources: {
						requests: {
							memory: "16Mi"
							cpu:    "150m"
						}
						limits: {
							memory: "64Mi"
							cpu:    "400m"
						}
					}
					imagePullPolicy: v1.#PullIfNotPresent
				}]
			}
		}
	}
}]
