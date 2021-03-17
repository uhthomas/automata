package server

import (
	"k8s.io/api/core/v1"
	appsv1 "k8s.io/api/apps/v1"
)

deployment: [...appsv1.#Deployment]

deployment: [{
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name: "server"
		labels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/version":   "2.25.1"
			"app.kubernetes.io/component": "server"
		}
	}
	spec: {
		// no autoscaling, we're using a PVC
		replicas: 1
		strategy: type: "Recreate"
		selector: matchLabels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/component": "server"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "prometheus"
				"app.kubernetes.io/instance":  "prometheus"
				"app.kubernetes.io/component": "server"
			}
			spec: {
				containers: [{
					name:  "server"
					image: "prom/prometheus:v2.25.1@sha256:1b4ed7c0e11efb8f68bbc913909d7650a46cb783d84cf541ee5e054925d6173f"
					ports: [{
						name:          "http"
						containerPort: 9090
					}]
					args: [
						"--storage.tsdb.retention.time=4h",
						"--config.file=/etc/config-reload/prometheus.yaml",
						"--storage.tsdb.path=/data",
						"--web.console.libraries=/etc/prometheus/console_libraries",
						"--web.console.templates=/etc/prometheus/consoles",
						"--web.enable-lifecycle",
						"--storage.tsdb.min-block-duration=2h",
						"--storage.tsdb.max-block-duration=2h",
					]
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/config/prometheus.yaml"
						readOnly:  true
						subPath:   "prometheus.ini"
					}]
					livenessProbe: {
						httpGet: {
							path: "/-/healthy"
							port: "http"
						}
						initialDelaySeconds: 30
						periodSeconds:       15
					}
					readinessProbe: {
						httpGet: {
							path: "/-/ready"
							port: "http"
						}
						initialDelaySeconds: 30
						periodSeconds:       15
					}
					imagePullPolicy: v1.#PullIfNotPresent
				}, {
					name:  "thanos-sidecar"
					image: "quay.io/thanos/thanos:v0.18.0@sha256:b94171aed499b2f1f81b6d3d385e0eeeca885044c59cef28ce6a9a9e8a827217"
					ports: [{
						name:          "thanos-http"
						containerPort: 8080
					}, {
						name:          "thanos-grpc"
						containerPort: 50051
					}]
					args: [
						"sidecar",
						"--grpc-address=:50051",
						"--grpc-grace-period=5s",
						"--http-address=:8080",
						"--http-grace-period=5s",
						"--tsdb.path=/data",
						"--prometheus.url=http://127.0.0.1:9090",
						"--objstore.config-file=/etc/secret/objstore.yaml",
						"--reloader.config-file=/etc/config/prometheus.yaml",
						"--reloader.config-envsubst-file=/etc/config-reload/prometheus.yaml",
					]
					env: [{
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}]
					volumeMounts: [{
						name:      "storage"
						mountPath: "/data"
					}, {
						name:      "thanos-sidecar"
						mountPath: "/etc/secret"
						readOnly:  true
					}, {
						name:      "config"
						mountPath: "/etc/config"
					}, {
						name:      "config-reload"
						mountPath: "/etc/config-reload"
					}]
					livenessProbe: {
						httpGet: {
							path: "/-/healthy"
							port: "thanos-http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
					readinessProbe: {
						httpGet: {
							path: "/-/ready"
							port: "thanos-http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				volumes: [{
					name: "storage"
					persistentVolumeClaim: claimName: "server"
				}, {
					name: "config"
					configMap: name: "server"
				}, {
					name: "config-reload"
					emptyDir: {}
				}, {
					name: "thanos-sidecar"
					secret: secretName: "thanos-sidecar"
				}]
				serviceAccountName: "server"
			}
		}
	}
}]
