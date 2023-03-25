package grafana_agent

import "k8s.io/api/core/v1"

#GrafanaAgentList: v1.#List & {
	apiVersion: "monitoring.grafana.com/v1alpha1"
	kind:       "GrafanaAgentList"
	items: [...{
		apiVersion: "monitoring.grafana.com/v1alpha1"
		kind:       "GrafanaAgent"
	}]
}

#GrafanaAgentList: items: [{
	spec: {
		image: "grafana/agent:v0.32.1"
		integrations: selector: matchLabels: agent: #Name
		logs: instanceSelector: matchLabels: agent: #Name
		metrics: {
			externalLabels: cluster: "unwind"
			instanceSelector: matchLabels: agent: #Name
		}
		serviceAccountName: #Name
	}
}]
