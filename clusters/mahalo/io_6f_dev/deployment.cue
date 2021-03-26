package io_6f_dev

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
			"app.kubernetes.io/name":      "io-6f-dev"
			"app.kubernetes.io/instance":  "io-6f-dev"
			"app.kubernetes.io/component": "io-6f-dev"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "io-6f-dev"
				"app.kubernetes.io/instance":  "io-6f-dev"
				"app.kubernetes.io/component": "io-6f-dev"
			}
			spec: containers: [{
				name:            "io-6f-dev"
				image:           "ghcr.io/uhthomas/6f.io:v1.4.0@sha256:142d56f20b64593c91131c66cefdd74fa06a8dab6607d46e2f9a910f9ac4d4eb"
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
