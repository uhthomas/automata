package compact

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
	metadata: annotations: "reloader.stakater.com/auto": "true"
	spec: {
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: type: "Recreate"
		minReadySeconds: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "thanos"
			"app.kubernetes.io/instance":  "thanos"
			"app.kubernetes.io/component": "compact"
		}
		replicas: 1
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "thanos"
				"app.kubernetes.io/instance":  "thanos"
				"app.kubernetes.io/component": "compact"
			}
			spec: {
				containers: [{
					name:  "compact"
					image: "quay.io/thanos/thanos:v0.18.0@sha256:b94171aed499b2f1f81b6d3d385e0eeeca885044c59cef28ce6a9a9e8a827217"
					ports: [{
						name:          "http"
						containerPort: 80
					}]
					envFrom: [{
						configMapRef: name: "thanos"
					}, {
						secretRef: name: "thanos"
					}]
					args: [
						"compact",
						"-w",
						"--http-address=:80",
						"--http-grace-period=5s",
						"""
						--objstore.config=type: S3
						config:
						  bucket: $(BUCKET_NAME)
						  endpoint: $(BUCKET_HOST):$(BUCKET_PORT)
						  region: $(BUCKET_REGION)
						  insecure: true
						""",
						"--downsampling.disable",
						"--deduplication.replica-label=replica",
						"--data-dir=/tmp/scratch",
					]
					resources: {
						requests: {
							memory: "512Mi"
							cpu:    "1000m"
						}
						limits: {
							memory: "1Gi"
							cpu:    "1000m"
						}
					}
					volumeMounts: [{
						name:      "scratch"
						mountPath: "/tmp/scratch"
					}]
					livenessProbe: {
						httpGet: {
							path: "/-/healthy"
							port: "http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
					readinessProbe: {
						httpGet: {
							path: "/-/ready"
							port: "http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				volumes: [{
					name: "scratch"
					ephemeral: volumeClaimTemplate: spec: {
						accessModes: [v1.#ReadWriteOnce]
						storageClassName: "rook-ceph-replica-delete-block"
						resources: requests: storage: "30Gi"
					}
				}]
			}
		}
	}
}]
