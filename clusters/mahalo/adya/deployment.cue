package adya

import (
	"k8s.io/api/core/v1"
	appsv1 "k8s.io/api/apps/v1"
)

deploymentList: appsv1.#DeploymentList & {
	apiVersion: "v1"
	kind:       "List"
}

deploymentList: items: [{
	apiVersion: "apps/v1"
	kind:       "Deployment"
	spec: {
		replicas:                1
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: type: "Recreate"
		minReadySeconds: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "adya"
			"app.kubernetes.io/instance":  "adya"
			"app.kubernetes.io/component": "adya"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "adya"
				"app.kubernetes.io/instance":  "adya"
				"app.kubernetes.io/component": "adya"
			}
			spec: containers: [{
				name:  "adya"
				image: "ghcr.io/uhthomas/adya:v1.0.11@sha256:8ed1ae1097150bfd5e5ccd62b473d423258f3ad85781c3de5b08b84a21fc2ecd"
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
				imagePullPolicy: v1.#PullIfNotPresent
			}]
		}
	}
}]
