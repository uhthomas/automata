package sealed_secrets

import appsv1 "k8s.io/api/apps/v1"

deployment: [...appsv1.#Deployment]

deployment: [{
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: name: "sealed-secrets-controller"
		name:      "sealed-secrets-controller"
	}
	spec: {
		minReadySeconds:      30
		replicas:             1
		revisionHistoryLimit: 10
		selector: matchLabels: name: "sealed-secrets-controller"
		strategy: {
			rollingUpdate: {
				maxSurge:       "25%"
				maxUnavailable: "25%"
			}
			type: "RollingUpdate"
		}
		template: {
			metadata: labels: name: "sealed-secrets-controller"
			spec: {
				containers: [{
					command: [
						"controller",
					]
					image:           "quay.io/bitnami/sealed-secrets-controller:v0.15.0"
					imagePullPolicy: "Always"
					livenessProbe: httpGet: {
						path: "/healthz"
						port: "http"
					}
					name: "sealed-secrets-controller"
					ports: [{
						containerPort: 8080
						name:          "http"
					}]
					readinessProbe: httpGet: {
						path: "/healthz"
						port: "http"
					}
					securityContext: {
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
						runAsUser:              1001
					}
					stdin: false
					tty:   false
					volumeMounts: [{
						mountPath: "/tmp"
						name:      "tmp"
					}]
				}]
				securityContext: fsGroup: 65534
				serviceAccountName:            "sealed-secrets-controller"
				terminationGracePeriodSeconds: 30
				volumes: [{
					emptyDir: {}
					name: "tmp"
				}]
			}
		}
	}
}]
