package redis_operator

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
					name:  #Name
					image: "quay.io/spotahome/redis-operator:v\(#Version)@sha256:298767d6678598bd16248e9bb9941b897530e07c43d29eb07cb2297f55f8799c"
					ports: [{
						name:          "http"
						containerPort: 9710
					}]
					resources: {
						limits: {
							(v1.#ResourceCPU):    "100m"
							(v1.#ResourceMemory): "50Mi"
						}
						requests: {
							(v1.#ResourceCPU):    "10m"
							(v1.#ResourceMemory): "50Mi"
						}
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
