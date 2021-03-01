package root_dev

import appsv1 "k8s.io/api/apps/v1"

deployment: appsv1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name:      "root"
		namespace: "root-dev"
	}
	spec: {
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: rollingUpdate: maxUnavailable: 1
		minReadySeconds: 1
		selector: matchLabels: app: "root"
		template: {
			metadata: labels: app: "root"
			spec: containers: [{
				name: "root"
				// v1.3.3
				image:           "ghcr.io/uhthomas/6f.io@sha256:d973de42ea3d59cf941055add6de823c9a86b7cbb8d3a23caf85bbdbd0423991"
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
}
