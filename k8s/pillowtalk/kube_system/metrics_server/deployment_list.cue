package metrics_server

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
		strategy: rollingUpdate: maxUnavailable: 0
		minReadySeconds: 1
		selector: matchLabels: app: "metrics-server"
		template: {
			metadata: labels: app: "metrics-server"
			spec: {
				serviceAccountName: "metrics-server"
				volumes: [{
					// mount in tmp so we can safely use from-scratch images and/or read-only containers
					name: "tmp-dir"
					emptyDir: {}
				}]
				priorityClassName: "system-cluster-critical"
				containers: [{
					name:            "metrics-server"
					image:           "k8s.gcr.io/metrics-server/metrics-server:v0.4.4@sha256:f8643f007c8a604388eadbdac43d76b95b56ccd13f7447dd0934b594b9f7b363"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"--cert-dir=/tmp",
						"--secure-port=4443",
						"--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname",
						"--kubelet-use-node-status-port",
						"--metric-resolution=15s",
						"--kubelet-insecure-tls=true",
					]
					resources: requests: {
						cpu:    "100m"
						memory: "300Mi"
					}
					ports: [{
						name:          "https"
						containerPort: 4443
						protocol:      "TCP"
					}]
					readinessProbe: {
						httpGet: {
							path:   "/readyz"
							port:   "https"
							scheme: "HTTPS"
						}
						periodSeconds:    10
						failureThreshold: 3
					}
					livenessProbe: {
						httpGet: {
							path:   "/livez"
							port:   "https"
							scheme: "HTTPS"
						}
						periodSeconds:    10
						failureThreshold: 3
					}
					securityContext: {
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
						runAsUser:              1000
					}
					volumeMounts: [{
						name:      "tmp-dir"
						mountPath: "/tmp"
					}]
				}]
				nodeSelector: "kubernetes.io/os": "linux"
			}
		}
	}
}]
