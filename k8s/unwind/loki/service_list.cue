package loki

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
	metadata: {
		name: "loki-gateway"
		labels: "app.kubernetes.io/component": "gateway"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "gateway"
		}
	}
}, {
	metadata: {
		name: "loki-read-headless"
		labels: {
			"app.kubernetes.io/component":   "read"
			"prometheus.io/service-monitor": "false"
		}
	}
	spec: {
		clusterIP: v1.#ClusterIPNone
		ports: [{
			name:       "http-metrics"
			port:       3100
			targetPort: "http-metrics"
		}, {
			name:        "grpc"
			port:        9095
			targetPort:  "grpc"
			protocol:    "TCP"
			appProtocol: "tcp"
		}]
		selector: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "read"
		}
	}
}, {
	metadata: {
		name: "loki-read"
		labels: "app.kubernetes.io/component": "read"
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
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "read"
		}
	}
}, {
	metadata: name: "loki-memberlist"
	spec: {
		clusterIP: v1.#ClusterIPNone
		ports: [{
			name:       "tcp"
			port:       7946
			targetPort: "http-memberlist"
		}]
		selector: {
			"app.kubernetes.io/name":     "loki"
			"app.kubernetes.io/instance": "loki"
			"app.kubernetes.io/part-of":  "memberlist"
		}
	}
}, {
	metadata: {
		name: "loki-write-headless"
		labels: {
			"app.kubernetes.io/component":   "write"
			"prometheus.io/service-monitor": "false"
		}
	}
	spec: {
		clusterIP: v1.#ClusterIPNone
		ports: [{
			name:       "http-metrics"
			port:       3100
			targetPort: "http-metrics"
		}, {
			name:        "grpc"
			port:        9095
			targetPort:  "grpc"
			appProtocol: "tcp"
		}]
		selector: {
			"app.kubernetes.io/name":      "loki"
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "write"
		}
	}
}, {
	metadata: {
		name: "loki-write"
		labels: "app.kubernetes.io/component": "write"
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
			"app.kubernetes.io/instance":  "loki"
			"app.kubernetes.io/component": "write"
		}
	}
}]
