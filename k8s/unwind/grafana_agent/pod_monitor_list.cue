package grafana_agent

import "k8s.io/api/core/v1"

#PodMonitorList: v1.#List & {
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "PodMonitor"
	items: [...{
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "PodMonitor"
	}]
}

#PodMonitorList: items: [{
	spec: {
		namespaceSelector: any: true
		selector: matchLabels: {}
		podMetricsEndpoints: [{
			port:        "http-metrics"
			honorLabels: true
			relabelings: [{
				sourceLabels: ["__meta_kubernetes_service_annotation_prometheus_io_scrape"]
				action: "keep"
				regex:  "true"
			}]
		}]
	}
}]
