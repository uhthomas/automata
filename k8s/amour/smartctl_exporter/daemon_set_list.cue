package smartctl_exporter

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
					name: "dev"
					hostPath: path: "/dev"
				}]
				containers: [{
					name:  "smartctl-exporter"
					image: "quay.io/prometheuscommunity/smartctl-exporter:master@sha256:fc03c601d8f098c72804e424482802f951e5c1b748138d5a33340ef3ea18586e"
					args: ["--smartctl.interval=2m"]
					ports: [{
						name:          "http-metrics"
						containerPort: 9633
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "500m"
						(v1.#ResourceMemory): "64Mi"
					}
					volumeMounts: [{
						name:      "dev"
						readOnly:  true
						mountPath: "/dev"
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
						privileged: true
						runAsUser:  0
					}
				},
					// securityContext: {
					// 	capabilities: drop: ["ALL"]
					// 	readOnlyRootFilesystem:   true
					// 	allowPrivilegeEscalation: false
					// }
				]
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
