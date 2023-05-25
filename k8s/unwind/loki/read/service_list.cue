package read

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
	spec: {
		ports: [{
			name:       "http-metrics"
			port:       3100
			targetPort: "http-metrics"
		}, {
			name:       "grpc"
			port:       9095
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/component": #Component
		}
	}
}, {
	metadata: {
		name: "\(#Name)-headless"
		labels: "prometheus.io/service-monitor": "false"
	}
	spec: {
		ports: [{
			name:       "http-metrics"
			port:       3100
			targetPort: "http-metrics"
		}, {
			name:       "grpc"
			port:       9095
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/component": #Component
		}
		clusterIP: v1.#ClusterIPNone
	}
}]
