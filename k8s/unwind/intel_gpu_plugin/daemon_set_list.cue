package intel_gpu_plugin

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
					name: "podresources"
					hostPath: path: "/var/lib/kubelet/pod-resources"
				}, {
					name: "devfs"
					hostPath: path: "/dev/dri"
				}, {
					name: "sysfs"
					hostPath: path: "/sys/class/drm"
				}, {
					name: "kubeletsockets"
					hostPath: path: "/var/lib/kubelet/device-plugins"
				}, {
					name: "nfd-source-hooks"
					hostPath: {
						path: "/etc/kubernetes/node-feature-discovery/source.d/"
						type: v1.#HostPathDirectoryOrCreate
					}
				}]
				containers: [{
					name:  #Name
					image: "intel/intel-gpu-plugin:\(#Version)"
					args: [
						"-shared-dev-num=300",
						"-resource-manager",

						// https://intel.github.io/intel-device-plugins-for-kubernetes/cmd/gpu_plugin/README.html#modes-and-configuration-options
						// https://github.com/intel/intel-device-plugins-for-kubernetes/blob/1ba2f7f0c5b098baeaf00083095b9767db36ba39/deployments/gpu_plugin/overlays/monitoring_shared-dev_nfd/add-args.yaml
						"-shared-dev-num=30",
						"-enable-monitoring",
						"-v=2",
					]
					env: [{
						name: "NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}]
					volumeMounts: [{
						mountPath: "/var/lib/kubelet/pod-resources"
						name:      "podresources"
					}, {
						mountPath: "/dev/dri"
						name:      "devfs"
						readOnly:  true
					}, {
						mountPath: "/sys/class/drm"
						name:      "sysfs"
						readOnly:  true
					}, {
						mountPath: "/var/lib/kubelet/device-plugins"
						name:      "kubeletsockets"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						seLinuxOptions: type: "container_device_plugin_t"
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				initContainers: [{
					name:  "intel-gpu-initcontainer"
					image: "intel/intel-gpu-initcontainer:\(#Version)"
					volumeMounts: [{
						mountPath: "/etc/kubernetes/node-feature-discovery/source.d/"
						name:      "nfd-source-hooks"
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						seLinuxOptions: type: "container_device_plugin_init_t"
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				nodeSelector: {
					"intel.feature.node.kubernetes.io/gpu": "true"
					(v1.#LabelArchStable):                  "amd64"
				}
				serviceAccountName: #Name
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}]
