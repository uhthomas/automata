package kipp_dev

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
			"app.kubernetes.io/name":      "kipp-dev"
			"app.kubernetes.io/instance":  "kipp-dev"
			"app.kubernetes.io/component": "kipp-dev"
		}
		template: {
			metadata: {
				annotations: {
					"prometheus.io/scrape": "true"
					"prometheus.io/path":   "/varz"
				}
				labels: {
					"app.kubernetes.io/name":      "kipp-dev"
					"app.kubernetes.io/instance":  "kipp-dev"
					"app.kubernetes.io/component": "kipp-dev"
				}
			}
			spec: {
				containers: [{
					name:  "kipp"
					image: "uhthomas/kipp:v0.2.1@sha256:1c1ab66793cd2232552ec3e6fe08588297cec5ed45b7de84e6a057148c874263"
					args: [
						"--database=$(DATABASE)",
						"--filesystem=s3://fr-par/kipp-dev?endpoint=s3.fr-par.scw.cloud",
					]
					ports: [{
						name:          "http"
						containerPort: 80
					}]
					env: [{
						name:  "AWS_SHARED_CREDENTIALS_FILE"
						value: "/aws-config"
					}, {
						name: "DATABASE"
						valueFrom: secretKeyRef: {
							name: "kipp-dev"
							key:  "database"
						}
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
					volumeMounts: [{
						name:      "secret"
						mountPath: "/aws-config"
						readOnly:  true
						subPath:   "aws-config"
					}]
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: "http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
					readinessProbe: {
						httpGet: {
							path: "/healthz"
							port: "http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				volumes: [{
					name: "secret"
					secret: secretName: "kipp-dev"
				}]
			}
		}
	}
}]
