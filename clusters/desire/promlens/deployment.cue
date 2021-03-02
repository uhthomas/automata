package promlens

import appsv1 "k8s.io/api/apps/v1"

deployment: appsv1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "promlens"
	spec: {
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: rollingUpdate: maxUnavailable: 1
		minReadySeconds: 1
		selector: matchLabels: app: "promlens"
		template: {
			metadata: labels: app: "promlens"
			spec: containers: [{
				name: "promlens"
				// v0.11.1
				image:           "promlabs/promlens@sha256:69aaabd1a7f3236074d6d10910dc41b016200d4159986d893c205920e76b31e7"
				imagePullPolicy: "IfNotPresent"
				ports: [{
					name:          "http"
					containerPort: 80
				}]
				args: [
					"--web.listen-address=:80",
					"--web.external-url=http://promlens.6f.io",
					"--web.default-prometheus-url=https://thanos.6f.io",
				]
				resources: {
					requests: {
						memory: "16Mi"
						cpu:    "50m"
					}
					limits: {
						memory: "32Mi"
						cpu:    "100m"
					}
				}
			}]
		}
	}
}
