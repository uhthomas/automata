package grafana_agent_operator

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

deploymentList: appsv1.#DeploymentList & {
	apiVersion: "apps/v1"
	kind:       "DeploymentList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}]
}

deploymentList: items: [{
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":     "grafana-agent-operator"
			"app.kubernetes.io/instance": "grafana-agent-operator"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":     "grafana-agent-operator"
				"app.kubernetes.io/instance": "grafana-agent-operator"
			}
			spec: {
				serviceAccountName: "grafana-agent-operator"
				containers: [{
					name:            "grafana-agent-operator"
					image:           "docker.io/grafana/agent-operator:v0.31.3"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [ "--kubelet-service=default/kubelet"]
				}]
			}
		}
	}
}]
