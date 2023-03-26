package grafana_agent_operator

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
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":     #Name
			"app.kubernetes.io/instance": #Name
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":     #Name
				"app.kubernetes.io/instance": #Name
			}
			spec: {
				serviceAccountName: #Name
				containers: [{
					name:            "operator"
					image:           "grafana/agent-operator:v\(#Version)"
					imagePullPolicy: v1.#PullIfNotPresent
					args: ["--log.level=debug", "--kubelet-service=\(#Namespace)/kubelet"]
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
