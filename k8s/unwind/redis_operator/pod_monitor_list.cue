package redis_operator

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
		selector: matchLabels: "app.kubernetes.io/name": #Name
		podMetricsEndpoints: [{port: "metrics"}]
	}
}]
