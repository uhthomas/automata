package prometheus

import "k8s.io/api/core/v1"

serviceMonitorList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "ServiceMonitor"
	}]
}

serviceMonitorList: items: [{
	metadata: name: "kube-state-metrics"
	spec: {
		endpoints: [{port: "http-metrics"}, {port: "telemetry"}]
		selector: matchLabels: {
			"app.kubernetes.io/name":      "kube-state-metrics"
			"app.kubernetes.io/instance":  "kube-state-metrics"
			"app.kubernetes.io/component": "kube-state-metrics"
		}
		namespaceSelector: matchNames: ["kube-state-metrics"]
	}
}, {
	metadata: name: "kube-dns"
	spec: {
		endpoints: [{port: "metrics"}]
		selector: matchLabels: "k8s-app": "kube-dns"
		namespaceSelector: matchNames: ["kube-system"]
	}
}, {
	metadata: name: "node-exporter"
	spec: {
		endpoints: [{port: "metrics"}]
		selector: matchLabels: {
			"app.kubernetes.io/name":      "node-exporter"
			"app.kubernetes.io/instance":  "node-exporter"
			"app.kubernetes.io/component": "exporter"
		}
		namespaceSelector: matchNames: ["node-exporter"]
	}
}]
