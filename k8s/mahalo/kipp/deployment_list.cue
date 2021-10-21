package kipp

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
			"app.kubernetes.io/name":      "kipp"
			"app.kubernetes.io/instance":  "kipp"
			"app.kubernetes.io/component": "kipp"
		}
		template: {
			metadata: {
				annotations: {
					"prometheus.io/scrape": "true"
					"prometheus.io/path":   "/varz"
				}
				labels: {
					"app.kubernetes.io/name":      "kipp"
					"app.kubernetes.io/instance":  "kipp"
					"app.kubernetes.io/component": "kipp"
				}
			}
			spec: {
				containers: [{
					name:  "kipp"
					image: "uhthomas/kipp:v0.2.1@sha256:1c1ab66793cd2232552ec3e6fe08588297cec5ed45b7de84e6a057148c874263"
					args: [
						"--database=$(DATABASE)",
						"--filesystem=s3://fr-par/kipp?endpoint=s3.fr-par.scw.cloud",
						"--lifetime=0",
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
							name: "kipp"
							key:  "database"
						}
					}]
					resources: {
						requests: {
							memory: "32Mi"
							cpu:    "500m"
						}
						limits: {
							memory: "256Mi"
							cpu:    "1000m"
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
					secret: secretName: "kipp"
				}]
			}
		}
	}
}, {
	metadata: {
		name: "kipp-static"
		labels: "app.kubernetes.io/component": "static"
	}
	spec: {
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: rollingUpdate: maxUnavailable: 1
		minReadySeconds: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "kipp"
			"app.kubernetes.io/instance":  "kipp"
			"app.kubernetes.io/component": "static"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "kipp"
				"app.kubernetes.io/instance":  "kipp"
				"app.kubernetes.io/component": "static"
			}
			spec: {
				containers: [{
					name:  "nginx"
					image: "nginx:1.21.3@sha256:7250923ba3543110040462388756ef099331822c6172a050b12c7a38361ea46f"
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
					volumeMounts: [{
						name:      "static"
						mountPath: "/usr/share/nginx/html"
						readOnly:  true
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
					name: "static"
					configMap: name: "kipp-static"
				}]
			}
		}
	}
}]
