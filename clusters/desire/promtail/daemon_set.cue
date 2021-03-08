package promtail

import appsv1 "k8s.io/api/apps/v1"

daemon_set: [...appsv1.#DaemonSet]

daemon_set: [{
	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	metadata: name: "promtail"
	spec: {
		revisionHistoryLimit: 5
		updateStrategy: type: "RollingUpdate"
		minReadySeconds: 1
		selector: matchLabels: app: "promtail"
		template: {
			metadata: {
				annotations: "prometheus.io/scrape": "true"
				labels: app:                         "promtail"
			}
			spec: {
				serviceAccountName: "promtail"
				tolerations: [{
					key:    "node-role.kubernetes.io/master"
					effect: "NoSchedule"
				}]
				containers: [{
					name: "promtail"
					// master-4f27c75
					image:           "grafana/promtail@sha256:2c1d84ba581b4ff2b8f3377e3ec76fd0df7ad2a4837488878d06748c47798d54"
					imagePullPolicy: "IfNotPresent"
					args: ["--config.file=/etc/promtail/promtail.yaml"]
					env: [{
						name: "HOSTNAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}]
					ports: [{
						name:          "http-metrics"
						containerPort: 3101
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
