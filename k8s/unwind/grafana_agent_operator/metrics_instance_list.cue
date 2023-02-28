package grafana_agent_operator

import "k8s.io/api/core/v1"

metricsInstanceList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "monitoring.grafana.com/v1alpha1"
		kind:       "MetricsInstance"
	}]
}

metricsInstanceList: items: [{}]
