package grafana_agent

import "k8s.io/api/core/v1"

#MetricsInstanceList: v1.#List & {
	apiVersion: "monitoring.grafana.com/v1alpha1"
	kind:       "MetricsInstanceList"
	items: [...{
		apiVersion: "monitoring.grafana.com/v1alpha1"
		kind:       "MetricsInstance"
	}]
}

#MetricsInstanceList: items: [{
	spec: {
		remoteWrite: [{
			url: "http://mimir-nginx.mimir.svc/api/v1/push"
		}, {
			url: "http://vminsert-vm.vm.svc:8480/insert/0/prometheus"
		}]

		serviceMonitorNamespaceSelector: {}
		serviceMonitorSelector: matchLabels: {}

		podMonitorNamespaceSelector: {}
		podMonitorSelector: matchLabels: {}

		probeNamespaceSelector: {}
		probeSelector: matchLabels: {}
	}
}]
