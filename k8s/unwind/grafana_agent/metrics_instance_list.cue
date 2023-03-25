package grafana_agent_operator

import "k8s.io/api/core/v1"

#MetricsInstanceList: v1.#List & {
	apiVersion: "monitoring.grafana.com/v1alpha1"
	kind:       "MetricsInstanceList"
	items: [...{
		apiVersion: "monitoring.grafana.com/v1alpha1"
		kind:       "MetricsInstance"
	}]
}

#MetricsInstanceList: items: [{}]
