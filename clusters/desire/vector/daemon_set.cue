package vector

import appsv1 "k8s.io/api/apps/v1"

daemon_set: [...appsv1.#DaemonSet]

daemon_set: [{
	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	metadata: name: "vector"
	spec: {
		revisionHistoryLimit: 5
		updateStrategy: type: "RollingUpdate"
		minReadySeconds: 1
		selector: matchLabels: app: "vector"
		template: {
			metadata: {
				annotations: "prometheus.io/scrape": "true"
				labels: app:                         "vector"
			}
			spec: {
				serviceAccountName: "vector"
				tolerations: [{
					key:    "node-role.kubernetes.io/master"
					effect: "NoSchedule"
				}]
				containers: [{
					name: "vector"
					// 0.11.1-distroless-static
					image:           "timberio/vector@sha256:68225be393f729060ddcb6a1666679f6dfe43f0745463490ea77bce969303fdd"
					imagePullPolicy: "IfNotPresent"
					env: [{
						name: "VECTOR_SELF_NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}, {
						name: "VECTOR_SELF_POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name: "VECTOR_SELF_POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "PROCFS_ROOT"
						value: "/host/proc"
					}, {
						name:  "SYSFS_ROOT"
						value: "/host/sys"
					}, {
						name:  "LOG"
						value: "info"
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
						name:      "var-log"
						mountPath: "/var/log"
						readOnly:  true
					}, {
						name:      "var-lib"
						mountPath: "/var/lib"
						readOnly:  true
					}, {
						name:      "proc"
						mountPath: "/host/proc"
						readOnly:  true
					}, {
						name:      "sys"
						mountPath: "/host/sys"
						readOnly:  true
					}, {
						name:      "config"
						mountPath: "/etc/vector"
						readOnly:  true
					}, {
						name:      "var-lib-vector"
						mountPath: "/var/lib/vector"
					}]
				}]
				volumes: [{
					name: "var-log"
					hostPath: path: "/var/log/"
				}, {
					name: "var-lib"
					hostPath: path: "/var/lib/"
				}, {
					name: "proc"
					hostPath: path: "/proc"
				}, {
					name: "sys"
					hostPath: path: "/sys"
				}, {
					name: "config"
					configMap: name: "vector"
				}, {
					name: "var-lib-vector"
					hostPath: path: "/var/lib/vector/"
				}]
			}
		}
	}
}]
