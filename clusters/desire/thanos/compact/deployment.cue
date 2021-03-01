package compact

import appsv1 "k8s.io/api/apps/v1"

deployment: appsv1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "compact"
	spec: {
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: type: "Recreate"
		minReadySeconds: 1
		selector: matchLabels: app: "compact"
		replicas: 1
		template: {
			metadata: {
				annotations: "prometheus.io/scrape": "true"
				labels: app:                         "compact"
			}
			spec: {
				containers: [{
					name: "compact"
					// v0.18.0
					image:           "quay.io/thanos/thanos@sha256:b94171aed499b2f1f81b6d3d385e0eeeca885044c59cef28ce6a9a9e8a827217"
					imagePullPolicy: "IfNotPresent"
					ports: [{
						name:          "http"
						containerPort: 80
					}]
					args: [
						"compact",
						"-w",
						"--http-address=:80",
						"--http-grace-period=5s",
						"--objstore.config-file=/etc/secret/objstore.yaml",
						"--downsampling.disable",
						"--deduplication.replica-label=replica",
					]
					resources: {
						requests: {
							memory:              "256Mi"
							cpu:                 "50m"
							"ephemeral-storage": "10Gi"
						}
						limits: {
							memory:              "512Mi"
							cpu:                 "350m"
							"ephemeral-storage": "10Gi"
						}
					}
					volumeMounts: [{
						name:      "thanos"
						mountPath: "/etc/secret"
						readOnly:  true
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
				}]
				volumes: [{
					name: "thanos"
					secret: secretName: "thanos"
				}]
			}
		}
	}
}
