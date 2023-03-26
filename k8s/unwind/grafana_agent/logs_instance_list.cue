package grafana_agent

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
	spec: {
		clients: [{
			externalLabels: cluster: "unwind"
			url: "http://loki-gateway.loki.svc/loki/api/v1/push"
		}]
		podLogsNamespaceSelector: {}
		podLogsSelector: matchLabels: {}
	}
}]
