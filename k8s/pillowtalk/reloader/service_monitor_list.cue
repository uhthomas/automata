package reloader

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
	spec: {
		endpoints: [{
                        targetPort: "http"
                        path: "/metrics"
                }]
		jobLabel: "app.kubernetes.io/name"
		selector: matchLabels: {
			"app.kubernetes.io/name":      "reloader"
			"app.kubernetes.io/instance":  "reloader"
			"app.kubernetes.io/component": "reloader"
		}
	}
}]
