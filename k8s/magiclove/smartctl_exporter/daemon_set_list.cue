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
					name: "smartctl-exporter"
					// Using master for:
					//
					// https://github.com/prometheus-community/smartctl_exporter/pull/211
					//
					// TODO: Use stable release when available.
					image: "quay.io/prometheuscommunity/smartctl-exporter:master@sha256:3b5234ffd1020bb3d783725a257762680bf63dfba567c03694e3c56430cae7bc"
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
