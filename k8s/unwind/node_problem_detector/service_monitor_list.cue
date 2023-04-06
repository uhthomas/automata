package node_problem_detector

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
		selector: matchLabels: app: "node-problem-detector"
		namespaceSelector: matchNames: [#Namespace]
		endpoints: [{
			port:     "exporter"
			path:     "/metrics"
			interval: "60s"
			relabelings: [{
				action:      "replace"
				targetLabel: "node"
				sourceLabels: ["__meta_kubernetes_pod_node_name"]
			}, {
				action:      "replace"
				targetLabel: "host_ip"
				sourceLabels: ["__meta_kubernetes_pod_host_ip"]
			}]
		}]
	}
}]
