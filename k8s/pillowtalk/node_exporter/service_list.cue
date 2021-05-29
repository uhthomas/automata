package node_exporter

import "k8s.io/api/core/v1"

serviceList: v1.#ServiceList & {
	apiVersion: "v1"
	kind:       "ServiceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Service"
	}]
}

serviceList: items: [{
	spec: {
		ports: [{
			name:       "metrics"
			port:       9100
			targetPort: "metrics"
		}]
		clusterIP:v1.#ClusterIPNone
		selector: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/component": "node-exporter"
		}
	}
}]
