package adya

import appsv1 "k8s.io/api/apps/v1"

deployment: appsv1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "adya"
	spec: {
		replicas:                1
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: type: "Recreate"
		minReadySeconds: 1
		selector: matchLabels: app: "adya"
		template: {
			metadata: labels: app: "adya"
			spec: containers: [{
				name:            "adya"
				image:           "ghcr.io/uhthomas/adya:v1.0.11"
				imagePullPolicy: "IfNotPresent"
				env: [{
					name: "TOKEN"
					valueFrom: secretKeyRef: {
						name: "adya"
						key:  "token"
					}
				}, {
					name:  "ADMINS"
					value: "105750004563509248"
				}]
				resources: {
					requests: {
						memory: "8Mi"
						cpu:    "10m"
					}
					limits: {
						memory: "16Mi"
						cpu:    "20m"
					}
				}
			}]
		}
	}
}
