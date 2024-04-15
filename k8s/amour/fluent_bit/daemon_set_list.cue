package fluent_bit

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
					name: "config"
					configMap: name: #Name
				}, {
					name: "var-log"
					hostPath: path: "/var/log"
				}, {
					name: "etc-machine-id"
					hostPath: {
						path: "/etc/machine-id"
						type: v1.#HostPathFile
					}
				}]
				containers: [{
					name:  "fluent-bit"
					image: "cr.fluentbit.io/fluent/fluent-bit:\(#Version)"
					command: ["/fluent-bit/bin/fluent-bit"]
					args: [
						"--workdir=/fluent-bit/etc",
						"--config=/fluent-bit/etc/conf/fluent-bit.yaml",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 2020
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "300m"
						(v1.#ResourceMemory): "128Mi"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/fluent-bit/etc/conf"
					}, {
						name:      "var-log"
						mountPath: "/var/log"
						readOnly:  true
					}, {
						name:      "etc-machine-id"
						mountPath: "/etc/machine-id"
						readOnly:  true
					}]
					livenessProbe: httpGet: {
						path: "/"
						port: "http-metrics"
					}
					readinessProbe: httpGet: {
						path: "/api/v1/health"
						port: "http-metrics"
					}
					imagePullPolicy: v1.#PullIfNotPresent
					// securityContext: {
					// 	capabilities: drop: ["ALL"]
					// 	readOnlyRootFilesystem:   true
					// 	allowPrivilegeEscalation: false
					// }
				}]
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
