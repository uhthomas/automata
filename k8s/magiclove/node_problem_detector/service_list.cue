package node_problem_detector

import "k8s.io/api/core/v1"

#ServiceList: v1.#ServiceList & {
	apiVersion: "v1"
	kind:       "ServiceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Service"
	}]
}

#ServiceList: items: [{
	metadata: annotations: {
		"prometheus.io/scrape": "true"
		"prometheus.io/scheme": "http"
		"prometheus.io/port":   "exporter"
		"prometheus.io/path":   "/metrics"
	}
	spec: {
		ports: [{
			name: "exporter"
			port: 20257
		}]
		selector: "app.kubernetes.io/name": "node-problem-detector"
		clusterIP: v1.#ClusterIPNone
	}
}]
