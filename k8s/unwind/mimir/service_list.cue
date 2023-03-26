package mimir

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
		name: "mimir-compactor"
		labels: {
			"app.kubernetes.io/component": "compactor"
			"app.kubernetes.io/part-of":   "memberlist"
		}
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "compactor"
		}
	}
}, {
	metadata: {
		name: "mimir-distributor-headless"
		labels: {
			"app.kubernetes.io/component":   "distributor"
			"app.kubernetes.io/part-of":     "memberlist"
			"prometheus.io/service-monitor": "false"
		}
	}
	spec: {
		clusterIP: "None"
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "distributor"
		}
	}
}, {
	metadata: {
		name: "mimir-distributor"
		labels: {
			"app.kubernetes.io/component": "distributor"
			"app.kubernetes.io/part-of":   "memberlist"
		}
		annotations: {}
		namespace: "mimir"
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "distributor"
		}
	}
}, {
	metadata: {
		name: "mimir-gossip-ring"
		labels: "app.kubernetes.io/component": "gossip-ring"
		namespace: "mimir"
	}
	spec: {
		clusterIP: "None"
		ports: [{
			name:       "gossip-ring"
			port:       7946
			targetPort: 7946
		}]
		publishNotReadyAddresses: true
		selector: {
			"app.kubernetes.io/name":     "mimir"
			"app.kubernetes.io/instance": "mimir"
			"app.kubernetes.io/part-of":  "memberlist"
		}
	}
}, {
	metadata: {
		name: "mimir-ingester-headless"
		labels: {
			"app.kubernetes.io/component":   "ingester"
			"app.kubernetes.io/part-of":     "memberlist"
			"prometheus.io/service-monitor": "false"
		}
		annotations: {}
		namespace: "mimir"
	}
	spec: {
		clusterIP: "None"
		ports: [{
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "ingester"
		}
	}
}, {
	metadata: {
		name: "mimir-ingester-zone-a"
		labels: {
			"app.kubernetes.io/component": "ingester"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "ingester-zone-a"
			"rollout-group":               "ingester"
			zone:                          "zone-a"
		}
		annotations: {}
		namespace: "mimir"
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "ingester"
			"rollout-group":               "ingester"
			zone:                          "zone-a"
		}
	}
}, {
	metadata: {
		name: "mimir-ingester-zone-b"
		labels: {
			"app.kubernetes.io/component": "ingester"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "ingester-zone-b"
			"rollout-group":               "ingester"
			zone:                          "zone-b"
		}
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "ingester"
			"rollout-group":               "ingester"
			zone:                          "zone-b"
		}
	}
}, {
	metadata: {
		name: "mimir-ingester-zone-c"
		labels: {
			"app.kubernetes.io/component": "ingester"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "ingester-zone-c"
			"rollout-group":               "ingester"
			zone:                          "zone-c"
		}
		annotations: {}
		namespace: "mimir"
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "ingester"
			"rollout-group":               "ingester"
			zone:                          "zone-c"
		}
	}
}, {
	metadata: name: "mimir-nginx"
	spec: {
		ports: [{
			name:       "http-metric"
			port:       80
			targetPort: "http-metric"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "nginx"
		}
	}
}, {
	metadata: {
		name: "mimir-overrides-exporter"
		labels: "app.kubernetes.io/component": "overrides-exporter"
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "overrides-exporter"
		}
	}
}, {
	metadata: {
		name: "mimir-querier"
		labels: {
			"app.kubernetes.io/component": "querier"
			"app.kubernetes.io/part-of":   "memberlist"
		}
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "querier"
		}
	}
}, {
	metadata: {
		name: "mimir-query-frontend"
		labels: "app.kubernetes.io/component": "query-frontend"
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "query-frontend"
		}
	}
}, {
	metadata: {
		name: "mimir-query-scheduler-headless"
		labels: {
			"app.kubernetes.io/component":   "query-scheduler"
			"prometheus.io/service-monitor": "false"
		}
	}
	spec: {
		clusterIP:                "None"
		publishNotReadyAddresses: true
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "query-scheduler"
		}
	}
}, {
	metadata: {
		name: "mimir-query-scheduler"
		labels: "app.kubernetes.io/component": "query-scheduler"
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "query-scheduler"
		}
	}
}, {
	metadata: {
		name: "mimir-ruler"
		labels: {
			"app.kubernetes.io/component": "ruler"
			"app.kubernetes.io/part-of":   "memberlist"
		}
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "ruler"
		}
	}
}, {
	metadata: {
		name: "mimir-store-gateway-headless"
		labels: {
			"app.kubernetes.io/component":   "store-gateway"
			"app.kubernetes.io/part-of":     "memberlist"
			"prometheus.io/service-monitor": "false"
		}
	}
	spec: {
		clusterIP: "None"
		ports: [{
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "store-gateway"
		}
	}
}, {
	metadata: {
		name: "mimir-store-gateway-zone-a"
		labels: {
			"app.kubernetes.io/component": "store-gateway"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "store-gateway-zone-a"
			"rollout-group":               "store-gateway"
			zone:                          "zone-a"
		}
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "store-gateway"
			"rollout-group":               "store-gateway"
			zone:                          "zone-a"
		}
	}
}, {
	metadata: {
		name: "mimir-store-gateway-zone-b"
		labels: {
			"app.kubernetes.io/component": "store-gateway"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "store-gateway-zone-b"
			"rollout-group":               "store-gateway"
			zone:                          "zone-b"
		}
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "store-gateway"
			"rollout-group":               "store-gateway"
			zone:                          "zone-b"
		}
	}
}, {
	metadata: {
		name: "mimir-store-gateway-zone-c"
		labels: {
			"app.kubernetes.io/component": "store-gateway"
			"app.kubernetes.io/part-of":   "memberlist"
			name:                          "store-gateway-zone-c"
			"rollout-group":               "store-gateway"
			zone:                          "zone-c"
		}
	}
	spec: {
		ports: [{
			port:       8080
			name:       "http-metrics"
			targetPort: "http-metrics"
		}, {
			port:       9095
			name:       "grpc"
			targetPort: "grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "mimir"
			"app.kubernetes.io/instance":  "mimir"
			"app.kubernetes.io/component": "store-gateway"
			"rollout-group":               "store-gateway"
			zone:                          "zone-c"
		}
	}
}]
