package io_6f

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
			"app.kubernetes.io/name":      "io-6f"
			"app.kubernetes.io/instance":  "io-6f"
			"app.kubernetes.io/component": "io-6f"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "io-6f"
				"app.kubernetes.io/instance":  "io-6f"
				"app.kubernetes.io/component": "io-6f"
			}
			spec: containers: [{
				name:            "io-6f"
				image:           "ghcr.io/uhthomas/6f.io:v1.4.1@sha256:c701b9470881713d9618a8b9d157a4699921301d583f843f07a52578821137f3"
				imagePullPolicy: v1.#PullIfNotPresent
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
			}]
		}
	}
}]
