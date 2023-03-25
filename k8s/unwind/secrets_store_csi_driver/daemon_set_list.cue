package secrets_store_csi_driver

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
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
		updateStrategy: {
			rollingUpdate: maxUnavailable: 1
			type: appsv1.#RollingUpdateStatefulSetStrategyType
		}
		template: {
			metadata: {
				labels: #Labels
				annotations: "kubectl.kubernetes.io/default-container": "secrets-store"
			}
			spec: {
				serviceAccountName: #Name
				affinity: nodeAffinity: requiredDuringSchedulingIgnoredDuringExecution: nodeSelectorTerms: [{
					matchExpressions: [{
						key:      "type"
						operator: metav1.#LabelSelectorOpNotIn
						values: ["virtual-kubelet"]
					}]
				}]
				containers: [{
					name:            "node-driver-registrar"
					image:           "registry.k8s.io/sig-storage/csi-node-driver-registrar:v2.7.0"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"--v=5",
						"--csi-address=/csi/csi.sock",
						"--kubelet-registration-path=/var/lib/kubelet/plugins/csi-secrets-store/csi.sock",
					]
					livenessProbe: {
						exec: command: [
							"/csi-node-driver-registrar",
							"--kubelet-registration-path=/var/lib/kubelet/plugins/csi-secrets-store/csi.sock",
							"--mode=kubelet-registration-probe",
						]
						initialDelaySeconds: 30
						timeoutSeconds:      15
					}
					volumeMounts: [{
						name:      "plugin-dir"
						mountPath: "/csi"
					}, {
						name:      "registration-dir"
						mountPath: "/registration"
					}]
					resources: {
						limits: {
							cpu:    "100m"
							memory: "100Mi"
						}
						requests: {
							cpu:    "10m"
							memory: "20Mi"
						}
					}
				}, {
					name:  "secrets-store"
					image: "registry.k8s.io/csi-secrets-store/driver:v\(#Version)"
					args: [
						"--endpoint=$(CSI_ENDPOINT)",
						"--nodeid=$(KUBE_NODE_NAME)",
						"--provider-volume=/var/run/secrets-store-csi-providers",
						"--additional-provider-volume-paths=/etc/kubernetes/secrets-store-csi-providers",
						"--enable-secret-rotation=true",
						"--metrics-addr=:8095",
						"--provider-health-check-interval=2m",
						"--max-call-recv-msg-size=4194304",
					]
					env: [{
						name:  "CSI_ENDPOINT"
						value: "unix:///csi/csi.sock"
					}, {
						name: "KUBE_NODE_NAME"
						valueFrom: fieldRef: {
							apiVersion: "v1"
							fieldPath:  "spec.nodeName"
						}
					}]
					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: privileged: true
					ports: [{
						name:          "healthz"
						containerPort: 9808
					}, {
						name:          "metrics"
						containerPort: 8095
					}]
					livenessProbe: {
						failureThreshold: 5
						httpGet: {
							path: "/healthz"
							port: "healthz"
						}
						initialDelaySeconds: 30
						timeoutSeconds:      10
						periodSeconds:       15
					}
					volumeMounts: [{
						name:      "plugin-dir"
						mountPath: "/csi"
					}, {
						name:             "mountpoint-dir"
						mountPath:        "/var/lib/kubelet/pods"
						mountPropagation: v1.#MountPropagationBidirectional
					}, {
						name:      "providers-dir"
						mountPath: "/var/run/secrets-store-csi-providers"
					}, {
						name:      "providers-dir-0"
						mountPath: "/etc/kubernetes/secrets-store-csi-providers"
					}]
					resources: {
						limits: {
							cpu:    "200m"
							memory: "200Mi"
						}
						requests: {
							cpu:    "50m"
							memory: "100Mi"
						}
					}
				}, {
					name:            "liveness-probe"
					image:           "registry.k8s.io/sig-storage/livenessprobe:v2.9.0"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"--csi-address=/csi/csi.sock",
						"--probe-timeout=3s",
						"--http-endpoint=0.0.0.0:9808",
						"-v=2",
					]
					volumeMounts: [{
						name:      "plugin-dir"
						mountPath: "/csi"
					}]
					resources: {
						limits: {
							cpu:    "100m"
							memory: "100Mi"
						}
						requests: {
							cpu:    "10m"
							memory: "20Mi"
						}
					}
				}]
				volumes: [{
					name: "mountpoint-dir"
					hostPath: {
						path: "/var/lib/kubelet/pods"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					name: "registration-dir"
					hostPath: {
						path: "/var/lib/kubelet/plugins_registry/"
						type: v1.#HostPathDirectory
					}
				}, {
					name: "plugin-dir"
					hostPath: {
						path: "/var/lib/kubelet/plugins/csi-secrets-store/"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					name: "providers-dir"
					hostPath: {
						path: "/var/run/secrets-store-csi-providers"
						type: v1.#HostPathDirectoryOrCreate
					}
				}, {
					name: "providers-dir-0"
					hostPath: {
						path: "/etc/kubernetes/secrets-store-csi-providers"
						type: v1.#HostPathDirectoryOrCreate
					}
				}]
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				tolerations: [{operator: v1.#NodeSelectorOpExists}]
			}
		}
	}
}]
