package emqx_exporter

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
					secret: secretName: #Name
				}]
				containers: [{
					name:  "emqx-exporter"
					image: "emqx/emqx-exporter:\(#Version)"
					args: ["--config.file=/etc/emqx-exporter/config.yaml"]
					ports: [{
						name:          "http-metrics"
						containerPort: 8085
					}]
					resources: requests: {
						(v1.#ResourceCPU):    "100m"
						(v1.#ResourceMemory): "256Mi"
					}
					volumeMounts: [{
						name:      "config"
						mountPath: "/etc/emqx-exporter/config.yaml"
						subPath:   "config.yaml"
					}]

					let probe = {httpGet: port: "http-metrics"}

					livenessProbe:  probe
					readinessProbe: probe

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
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
