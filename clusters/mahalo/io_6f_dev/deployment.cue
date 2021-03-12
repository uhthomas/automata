package io_6f_dev

import appsv1 "k8s.io/api/apps/v1"

deployment: [...appsv1.#Deployment]

deployment: [{
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "io_6f"
	spec: {
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: rollingUpdate: maxUnavailable: 1
		minReadySeconds: 1
		selector: matchLabels: app: "io_6f"
		template: {
			metadata: labels: app: "io_6f"
			spec: containers: [{
				name: "io_6f"
				// v1.4.0
				image:           "ghcr.io/uhthomas/6f.io@sha256:142d56f20b64593c91131c66cefdd74fa06a8dab6607d46e2f9a910f9ac4d4eb"
				imagePullPolicy: "IfNotPresent"
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
