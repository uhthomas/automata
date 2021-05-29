package prometheus

import "k8s.io/api/core/v1"

podMonitorList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "PodMonitor"
	}]
}

podMonitorList: items: [{
	metadata: name: "rook-ceph"
	spec: {
		podMetricsEndpoints: [{port: "http-metrics"}]
		selector: matchLabels: app: "rook-ceph-mgr"
		namespaceSelector: matchNames: ["rook-ceph"]
	}
}]
