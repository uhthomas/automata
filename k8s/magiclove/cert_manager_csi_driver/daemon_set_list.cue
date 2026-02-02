package cert_manager_csi_driver

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
				containers: [{
					name:            "node-driver-registrar"
					image:           "registry.k8s.io/sig-storage/csi-node-driver-registrar:v2.15.0"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"-v=1",
						"--csi-address=/plugin/csi.sock",
						"--kubelet-registration-path=/var/lib/kubelet/plugins/cert-manager-csi-driver/csi.sock",
					]
					env: [{
						name: "KUBE_NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}]
					volumeMounts: [{
						name:      "plugin-dir"
						mountPath: "/plugin"
					}, {
						name:      "registration-dir"
						mountPath: "/registration"
					}]
				}, {
					name:  "liveness-probe"
					image: "k8s.gcr.io/sig-storage/livenessprobe:v2.6.0"
					args: [
						"--csi-address=/plugin/csi.sock",
						"--probe-timeout=3s",
						"--health-port=9809",
						"-v=1",
					]
					imagePullPolicy: v1.#PullIfNotPresent
					volumeMounts: [{
						name:      "plugin-dir"
						mountPath: "/plugin"
					}]
				}, {
					name: #Name
					securityContext: {
						privileged: true
						capabilities: add: ["SYS_ADMIN"]
						allowPrivilegeEscalation: true
					}
					image:           "quay.io/jetstack/cert-manager-csi-driver:v0.5.0"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"--log-level=1",
						"--driver-name=csi.cert-manager.io",
						"--node-id=$(NODE_ID)",
						"--endpoint=$(CSI_ENDPOINT)",
						"--data-root=csi-data-dir",
						"--use-token-request=false",
					]
					env: [{
						name: "NODE_ID"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}, {
						name:  "CSI_ENDPOINT"
						value: "unix://plugin/csi.sock"
					}]
					volumeMounts: [{
						name:      "plugin-dir"
						mountPath: "/plugin"
					}, {
						name:             "pods-mount-dir"
						mountPath:        "/var/lib/kubelet/pods"
						mountPropagation: v1.#MountPropagationBidirectional
					}, {
						name:             "csi-data-dir"
						mountPath:        "/csi-data-dir"
						mountPropagation: v1.#MountPropagationBidirectional
					}]
					ports: [{
						name:          "healthz"
						containerPort: 9809
					}]
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: "healthz"
						}
						initialDelaySeconds: 5
						timeoutSeconds:      5
					}
				}]
				volumes: [{
					name: "plugin-dir"
					hostPath: {
						path: "/var/lib/kubelet/plugins/cert-manager-csi-driver"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					name: "pods-mount-dir"
					hostPath: {
						path: "/var/lib/kubelet/pods"
						type: v1.#HostPathDirectory
					}
				}, {
					hostPath: {
						path: "/var/lib/kubelet/plugins_registry"
						type: v1.#HostPathDirectory
					}
					name: "registration-dir"
				}, {
					hostPath: {
						path: "/tmp/cert-manager-csi-driver"
						type: v1.#HostPathDirectoryOrCreate
					}
					name: "csi-data-dir"
				}]
				serviceAccountName: #Name
				tolerations: [{
					operator: v1.#TolerationOpExists
					effect:   v1.#TaintEffectNoSchedule
				}]
			}
		}
	}
}]
