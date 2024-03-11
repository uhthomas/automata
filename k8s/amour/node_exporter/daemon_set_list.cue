package node_exporter

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
					name: "proc"
					hostPath: path: "/proc"
				}, {
					name: "sys"
					hostPath: path: "/sys"
				}, {
					name: "root"
					hostPath: path: "/"
				}]
				containers: [{
					name:  "node-exporter"
					image: "quay.io/prometheus/node-exporter:v\(#Version)"
					args: [
						"--path.procfs=/host/proc",
						"--path.sysfs=/host/sys",
						"--path.rootfs=/host/root",
						"--path.udev.data=/host/root/run/udev/data",
						"--web.listen-address=[0.0.0.0]:9100",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 9100
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "1"
						(v1.#ResourceMemory): "256Mi"
					}
					volumeMounts: [{
						name:      "proc"
						readOnly:  true
						mountPath: "/host/proc"
					}, {
						name:      "sys"
						readOnly:  true
						mountPath: "/host/sys"
					}, {
						name:             "root"
						readOnly:         true
						mountPath:        "/host/root"
						mountPropagation: v1.#MountPropagationHostToContainer
					}]

					let probe = {
						httpGet: {
							path: "/"
							port: "http-metrics"
						}
					}

					livenessProbe:  probe
					readinessProbe: probe

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName:           #Name
				automountServiceAccountToken: false
				hostNetwork:                  true
				hostPID:                      true
				securityContext: {
					runAsUser:    1000
					runAsGroup:   3000
					runAsNonRoot: true
					fsGroup:      2000
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
				nodeSelector: (v1.#LabelOSStable): v1.#Linux
				tolerations: [{
					effect:   v1.#TaintEffectNoSchedule
					operator: v1.#NodeSelectorOpExists
				}]
			}
		}
	}
}]
