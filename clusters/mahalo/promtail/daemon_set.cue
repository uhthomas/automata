package promtail

import (
	"k8s.io/api/core/v1"
	appsv1 "k8s.io/api/apps/v1"
)

daemon_set: [...appsv1.#DaemonSet]

daemon_set: [{
	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	spec: {
		revisionHistoryLimit: 5
		updateStrategy: type: "RollingUpdate"
		minReadySeconds: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "promtail"
			"app.kubernetes.io/instance":  "promtail"
			"app.kubernetes.io/component": "promtail"
		}
		template: {
			metadata: {
				annotations: "prometheus.io/scrape": "true"
				labels: {
					"app.kubernetes.io/name":      "promtail"
					"app.kubernetes.io/instance":  "promtail"
					"app.kubernetes.io/component": "promtail"
				}
			}
			spec: {
				serviceAccountName: "promtail"
				tolerations: [{
					key:    "node-role.kubernetes.io/master"
					effect: "NoSchedule"
				}]
				containers: [{
					name:  "promtail"
					image: "grafana/promtail:master-594b596@sha256:16e9efd6c3c146146afd7d48c82d51ed5dda64dfd3c41a257b399b26ec8674fa"
					args: ["--config.file=/etc/promtail/promtail.yaml"]
					ports: [{
						name:          "http-metrics"
						containerPort: 3101
					}]
					env: [{
						name: "HOSTNAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}]
					resources: {
						requests: {
							cpu:    "50m"
							memory: "32Mi"
						}
						limits: {
							cpu:    "100m"
							memory: "64Mi"
						}
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/promtail"
						readOnly:  true
					}, {
						name:      "containers"
						mountPath: "/var/lib/docker/containers"
						readOnly:  true
					}, {
						name:      "pods"
						mountPath: "/var/log/pods"
						readOnly:  true
					}, {
						name:      "run"
						mountPath: "/run/promtail"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				volumes: [{
					name: "config"
					configMap: name: "promtail"
				}, {
					name: "containers"
					hostPath: path: "/var/lib/docker/containers"
				}, {
					name: "pods"
					hostPath: path: "/var/log/pods"
				}, {
					name: "run"
					hostPath: path: "/run/promtail"
				}]
			}
		}
	}
}]
