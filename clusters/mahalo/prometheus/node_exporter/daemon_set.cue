package node_exporter

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

daemon_set: [...appsv1.#DaemonSet]

daemon_set: [{
	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	metadata: {
		name: "node-exporter"
		labels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/version":   "1.2.2"
			"app.kubernetes.io/component": "node-exporter"
		}
	}
	spec: {
		revisionHistoryLimit: 5
		updateStrategy: type: "RollingUpdate"
		minReadySeconds: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/component": "node-exporter"
		}
		template: {
			metadata: {
				annotations: "prometheus.io/scrape": "true"
				labels: {
					"app.kubernetes.io/name":      "prometheus"
					"app.kubernetes.io/instance":  "prometheus"
					"app.kubernetes.io/component": "node-exporter"
				}
			}
			spec: {
				serviceAccountName: "node-exporter"
				tolerations: [{
					key:    "node-role.kubernetes.io/master"
					effect: "NoSchedule"
				}]
				containers: [{
					name:  "node-exporter"
					image: "quay.io/prometheus/node-exporter:v1.2.2@sha256:22fbde17ab647ddf89841e5e464464eece111402b7d599882c2a3393bc0d2810"

					ports: [{
						name:          "metrics"
						containerPort: 9100
					}]
					args: [
						"--path.procfs=/host/proc",
						"--path.sysfs=/host/sys",
						"--path.rootfs=/host/root",
						"--web.listen-address=:9100",
					]
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
						name:      "proc"
						mountPath: "/host/proc"
						readOnly:  true
					}, {
						name:      "sys"
						mountPath: "/host/sys"
						readOnly:  true
					}, {
						name:             "root"
						mountPath:        "/host/root"
						mountPropagation: v1.#MountPropagationHostToContainer
						readOnly:         true
					}]
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				volumes: [{
					name: "proc"
					hostPath: path: "/proc"
				}, {
					name: "sys"
					hostPath: path: "/sys"
				}, {
					name: "root"
					hostPath: path: "/"
				}]
			}
		}
	}
}]
