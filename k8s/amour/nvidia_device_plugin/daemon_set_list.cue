package nvidia_device_plugin

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
		selector: matchLabels: "app.kubernetes.io/name": "nvidia-device-plugin"
		template: {
			metadata: labels: "app.kubernetes.io/name": "nvidia-device-plugin"
			spec: {
				volumes: [{
					name: "config"
					configMap: name: #Name
				}, {
					name: "device-plugin"
					hostPath: path: "/var/lib/kubelet/device-plugins"
				}]
				containers: [{
					image: "nvcr.io/nvidia/k8s-device-plugin:v\(#Version)"
					name:  "nvidia-device-plugin-ctr"
					env: [{
						name:  "CONFIG_FILE"
						value: "/var/nvidia-device-plugin/config/config.yaml"
					}, {
						name:  "NVIDIA_MIG_MONITOR_DEVICES"
						value: "all"
					}]
					volumeMounts: [{
						name:      "config"
						mountPath: "/var/nvidia-device-plugin/config"
					}, {
						name:      "device-plugin"
						mountPath: "/var/lib/kubelet/device-plugins"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: capabilities: add: ["SYS_ADMIN"]
					// securityContext: {
					// 	capabilities: {
					// 		add: ["SYS_ADMIN"]
					// 		drop: ["ALL"]
					// 	}
					// 	readOnlyRootFilesystem:   true
					// 	allowPrivilegeEscalation: false
					// }
				}]
				tolerations: [{
					key:      "CriticalAddonsOnly"
					operator: v1.#TolerationOpExists
				}, {
					key:      "nvidia.com/gpu"
					operator: v1.#TolerationOpExists
					effect:   v1.#TaintEffectNoSchedule
				}]
				// securityContext: {
				// 	runAsUser:    1000
				// 	runAsGroup:   3000
				// 	runAsNonRoot: true
				// 	fsGroup:      2000
				// 	seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				// }
				priorityClassName: "system-node-critical"
			}
		}
	}
}]
