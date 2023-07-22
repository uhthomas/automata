package grafana_agent

import "k8s.io/api/core/v1"

#ServiceMonitorList: v1.#List & {
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "ServiceMonitor"
	items: [...{
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "ServiceMonitor"
	}]
}

#ServiceMonitorList: items: [{
	spec: {
		endpoints: [{
			port:        "http-metrics"
			honorLabels: true
			relabelings: [{
				sourceLabels: ["__meta_kubernetes_service_annotation_prometheus_io_scrape"]
				action: "keep"
				regex:  "true"
			}]
		}]
		namespaceSelector: any: true
		selector: matchLabels: {}
	}
}]
