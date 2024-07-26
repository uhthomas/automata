package ping_exporter

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
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
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": #Name
		template: {
			metadata: labels: "app.kubernetes.io/name": #Name
			spec: {
				volumes: [{
					name: "config"
					configMap: name: #Name
				}]
				containers: [{
					name:  "ping-exporter"
					image: "czerwonk/ping_exporter:v\(#Version)"
					command: ["/app/ping_exporter"]
					args: ["--config.path=/var/ping-exporter/config.yaml"]
					ports: [{
						name:          "http-metrics"
						containerPort: 9427
					}]
					resources: requests: {
						(v1.#ResourceCPU):    "100m"
						(v1.#ResourceMemory): "200Mi"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/var/ping-exporter/config.yaml"
						subPath:   "config.yaml"
					}]

					let probe = {httpGet: port: "http-metrics"}

					livenessProbe:  probe
					readinessProbe: probe

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: privileged: true
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
