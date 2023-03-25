package grafana_agent_operator

import "k8s.io/api/core/v1"

#LogsInstanceList: v1.#List & {
	apiVersion: "monitoring.grafana.com/v1alpha1"
	kind:       "LogsInstanceList"
	items: [...{
		apiVersion: "monitoring.grafana.com/v1alpha1"
		kind:       "LogsInstance"
	}]
}

#LogsInstanceList: items: [{
	clients: [{
		basicAuth: {
			password: {
				key:  "password"
				name: "logs-secret"
			}
			username: {
				key:  "username"
				name: "logs-secret"
			}
		}
		externalLabels: cluster: "${CLUSTER}"
		url: "${LOGS_URL}"
	}]
	podLogsNamespaceSelector: {}
	podLogsSelector: matchLabels: instance: "primary"
}]
