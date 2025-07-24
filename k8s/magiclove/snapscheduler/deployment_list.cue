package snapscheduler

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
				containers: [{
					name:  "manager"
					image: "quay.io/backube/snapscheduler:\(#Version)"
					command: ["/manager"]
					args: [
						"--health-probe-bind-address=:8081",
						"--metrics-bind-address=:8080",
						"--leader-elect",
					]
					ports: [{
						name:          "http-metrics"
						containerPort: 8080
					}, {
						name:          "http-health"
						containerPort: 8081
					}]
					resources: requests: {
						(v1.#ResourceCPU):    "100m"
						(v1.#ResourceMemory): "96Mi"
					}

					let probe = {httpGet: port: "http-health"}

					livenessProbe: probe & {httpGet: path: "/healthz"}
					readinessProbe: probe & {httpGet: path: "/readyz"}

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
		strategy: type: appsv1.#RecreateDeploymentStrategyType
	}
}]
