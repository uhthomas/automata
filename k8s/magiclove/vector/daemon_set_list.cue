package vector

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

#DaemonSetList: appsv1.#DaemonSetList & {
	apiVersion: "apps/v1"
	kind:       "DaemonSetList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "DaemonSet"
	}]
}

#DaemonSetList: items: [{
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: {
				"app.kubernetes.io/name": #Name
				"vector.dev/exclude":     "true"
			}
			spec: {
				volumes: [{
					name: "config"
					configMap: name: #Name
				}, {
					name: "data"
					hostPath: {
						path: "/var/lib/vector"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					name: "var-log"
					hostPath: {
						path: "/var/log"
						type: v1.#HostPathDirectory
					}
				}, {
					name: "var-lib"
					hostPath: {
						path: "/var/lib"
						type: v1.#HostPathDirectory
					}
				}, {
					name: "procfs"
					hostPath: {
						path: "/proc"
						type: v1.#HostPathDirectory
					}
				}, {
					name: "sysfs"
					hostPath: {
						path: "/sys"
						type: v1.#HostPathDirectory
					}
				}]
				containers: [{
					name:  "vector"
					image: "timberio/vector:\(#Version)-distroless-libc"
					args: ["--config-dir=/etc/vector"]
					ports: [{
						name:          "http-metrics"
						containerPort: 9090
					}]
					env: [{
						name:  "VECTOR_LOG"
						value: "info"
					}, {
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
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "1"
						(v1.#ResourceMemory): "1Gi"
					}
					volumeMounts: [{
						name:      "data"
						mountPath: "/vector-data-dir"
					}, {
						name:      "config"
						mountPath: "/etc/vector"
						readOnly:  true
					}, {
						name:      "var-log"
						mountPath: "/var/log"
						readOnly:  true
					}, {
						name:      "var-lib"
						mountPath: "/var/lib"
						readOnly:  true
					}, {
						name:      "procfs"
						mountPath: "/host/proc"
						readOnly:  true
					}, {
						name:      "sysfs"
						mountPath: "/host/sys"
						readOnly:  true
					}]
					// livenessProbe: httpGet: {
					// 	path: "/"
					// 	port: "http-metrics"
					// }
					// readinessProbe: httpGet: {
					// 	path: "/api/v1/health"
					// 	port: "http-metrics"
					// }
					imagePullPolicy: v1.#PullIfNotPresent
				},
					// securityContext: {
					// 	capabilities: drop: ["ALL"]
					// 	readOnlyRootFilesystem:   true
					// 	allowPrivilegeEscalation: false
					// }
				]
				serviceAccountName: #Name
				// securityContext: {
				// 	runAsUser:    1000
				// 	runAsGroup:   3000
				// 	runAsNonRoot: true
				// 	fsGroup:      2000
				// 	seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				// }
			}
		}
	}
}]
