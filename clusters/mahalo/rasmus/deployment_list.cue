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
			spec: containers: [{
				name:  "rasmus"
				image: "ghcr.io/uhthomas/rasmus:v0.2.9@sha256:5939c3b822a4cc63355293d1c3dbfc5dd6dd9de64a82550bacb57056eb3fe3f4"
				ports: [{
					name:          "http"
					containerPort: 8080
				}]
				env: [{
					name: "POD_IP"
					valueFrom: fieldRef: fieldPath: "status.podIP"
				}, {
					name:  "RELEASE_COOKIE"
					value: "0123456789abcdef"
				}]
				resources: {
					requests: {
						memory: "16Mi"
						cpu:    "150m"
					}
					limits: {
						memory: "128Mi"
						cpu:    "400m"
					}
				}
				imagePullPolicy: v1.#PullIfNotPresent
			}]
		}
	}
}]
