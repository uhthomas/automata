package grafana_operator

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
					name: "dashboards-dir"
					emptyDir: {}
				}]
				containers: [{
					name:  "manager"
					image: "ghcr.io/grafana/grafana-operator:v\(#Version)"
					args: [
						"--health-probe-bind-address=:8081",
						"--metrics-bind-address=0.0.0.0:9090",
						"--leader-elect",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 9090
					}]
					resources: limits: {
						(v1.#ResourceCPU):    "200m"
						(v1.#ResourceMemory): "256Mi"
					}
					volumeMounts: [{
						name:      "dashboards-dir"
						mountPath: "/tmp/dashboards"
					}]

					let probe = {httpGet: port: 8081}

					livenessProbe: probe & {
						httpGet: path: "/healthz"
						initialDelaySeconds: 15
						periodSeconds:       20
					}
					readinessProbe: probe & {
						httpGet: path: "/readyz"
						initialDelaySeconds: 5
						periodSeconds:       10
					}

					imagePullPolicy: v1.#PullIfNotPresent
					securityContext: {
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem:   true
						allowPrivilegeEscalation: false
					}
				}]
				serviceAccountName: #Name
				securityContext: {
					runAsUser:           1000
					runAsGroup:          3000
					runAsNonRoot:        true
					fsGroup:             2000
					fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
					seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
				}
			}
		}
	}
}]
