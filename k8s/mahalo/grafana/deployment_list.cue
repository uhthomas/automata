package grafana

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
			"app.kubernetes.io/name":      "grafana"
			"app.kubernetes.io/instance":  "grafana"
			"app.kubernetes.io/component": "grafana"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "grafana"
				"app.kubernetes.io/instance":  "grafana"
				"app.kubernetes.io/component": "grafana"
			}
			spec: {
				containers: [{
					name:            "grafana"
					image:           "grafana/grafana:8.0.3@sha256:7419f7943bc0dd90f1e13a12387db2fdad1eeeda055b82847ef33668b7811af8"
					imagePullPolicy: v1.#PullIfNotPresent
					ports: [{
						name:          "http"
						containerPort: 3000
					}]
					env: [{
						name: "GF_DEFAULT_INSTANCE_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name: "GF_DATABASE_HOST"
						valueFrom: secretKeyRef: {
							name: "grafana"
							key:  "database_host"
						}
					}, {
						name: "GF_DATABASE_NAME"
						valueFrom: secretKeyRef: {
							name: "grafana"
							key:  "database_name"
						}
					}, {
						name: "GF_DATABASE_USER"
						valueFrom: secretKeyRef: {
							name: "grafana"
							key:  "database_user"
						}
					}, {
						name: "GF_DATABASE_PASSWORD"
						valueFrom: secretKeyRef: {
							name: "grafana"
							key:  "database_password"
						}
					}]
					readinessProbe: {
						failureThreshold: 3
						httpGet: {
							path: "/api/health"
							port: "http"
						}
						periodSeconds:    10
						successThreshold: 1
						timeoutSeconds:   1
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/grafana/grafana.ini"
						readOnly:  true
						subPath:   "grafana.ini"
					}, {
						name:      "config"
						mountPath: "/etc/grafana/provisioning/datasources/datasources.yaml"
						readOnly:  true
						subPath:   "datasources.yaml"
					}]
				}]
				volumes: [{
					name: "config"
					configMap: name: "grafana"
				}]
			}
		}
	}
}]
