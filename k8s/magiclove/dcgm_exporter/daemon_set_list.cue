package dcgm_exporter

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
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "pod-gpu-resources"
					hostPath: path: "/var/lib/kubelet/pod-resources"
				}]
				containers: [{
					name:  "exporter"
					image: "nvcr.io/nvidia/k8s/dcgm-exporter:4.1.1-4.0.4-ubuntu22.04"
					args: ["-f", "/etc/dcgm-exporter/dcp-metrics-included.csv"]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}]
					env: [{
						name:  "DCGM_EXPORTER_LISTEN"
						value: ":8080"
					}, {
						name: "NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "200m"
						(v1.#ResourceMemory): "512Mi"
					}
					volumeMounts: [{
						name:      "pod-gpu-resources"
						readOnly:  true
						mountPath: "/var/lib/kubelet/pod-resources"
					}]

					let probe = {
						httpGet: {
							path: "/health"
							port: "http-metrics"
						}
					}

					livenessProbe: probe & {periodSeconds: 5}
					readinessProbe: probe

					imagePullPolicy: v1.#PullIfNotPresent
					// securityContext: {
					// 	capabilities: {
					// 		add: ["SYS_ADMIN"]
					// 		drop: ["ALL"]
					// 	}
					// 	readOnlyRootFilesystem:   true
					// 	allowPrivilegeEscalation: false
					// }
					securityContext: capabilities: add: ["SYS_ADMIN"]
				}]
				nodeSelector: (v1.#LabelHostname): "dice"

				// securityContext: {
				// 	runAsUser:    1000
				// 	runAsGroup:   3000
				// 	runAsNonRoot: true
				// 	fsGroup:      2000
				// 	seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				// }

				// TODO: Make the default runtime class nvidia
				runtimeClassName: "nvidia"
			}
		}
	}
}]
