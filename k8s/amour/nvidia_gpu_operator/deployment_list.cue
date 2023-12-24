package nvidia_gpu_operator

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DeploymentList: appsv1.#DeploymentList & {
	apiVersion: "apps/v1"
	kind:       "DeploymentList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}]
}

#DeploymentList: items: [{
	metadata: labels: "nvidia.com/gpu-driver-upgrade-drain.skip": "true"
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":                   #Name
				"nvidia.com/gpu-driver-upgrade-drain.skip": "true"
			}
			spec: {
				volumes: [{
					name: "host-os-release"
					hostPath: path: "/etc/os-release"
				}]
				containers: [{
					name:  "nvidia-gpu-operator"
					image: "nvcr.io/nvidia/gpu-operator:v\(#Version)"
					command: ["gpu-operator"]
					args: [
						"--leader-elect",
						"--zap-time-encoding=epoch",
						"--zap-log-level=info",
					]
					ports: [{
						name:          "metrics"
						containerPort: 8080
					}]
					env: [{
						name:  "WATCH_NAMESPACE"
						value: ""
					}, {
						name: "OPERATOR_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "DRIVER_MANAGER_IMAGE"
						value: "nvcr.io/nvidia/cloud-native/k8s-driver-manager:v0.6.2"
					}]
					resources: {
						limits: {
							cpu:    "500m"
							memory: "350Mi"
						}
						requests: {
							cpu:    "200m"
							memory: "100Mi"
						}
					}
					volumeMounts: [{
						name:      "host-os-release"
						mountPath: "/host-etc/os-release"
						readOnly:  true
					}]
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: 8081
						}
						initialDelaySeconds: 15
						periodSeconds:       20
					}
					readinessProbe: {
						httpGet: {
							path: "/readyz"
							port: 8081
						}
						initialDelaySeconds: 5
						periodSeconds:       10
					}
					imagePullPolicy: v1.#PullIfNotPresent
				}]
				serviceAccountName: #Name
				affinity: nodeAffinity: preferredDuringSchedulingIgnoredDuringExecution: [{
					preference: matchExpressions: [{
						key:      "node-role.kubernetes.io/control-plane"
						operator: metav1.#LabelSelectorOpIn
						values: [""]
					}]
					weight: 1
				}]
				tolerations: [{
					effect:   v1.#TaintEffectNoSchedule
					key:      "node-role.kubernetes.io/control-plane"
					operator: v1.#TolerationOpEqual
					value:    ""
				}]
				priorityClassName: "system-node-critical"
			}
		}
	}
}]
