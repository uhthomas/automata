package server

import "k8s.io/api/core/v1"

service: [...v1.#Service]

service: [{
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "server"
		labels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/version":   "2.25.1"
			"app.kubernetes.io/component": "server"
		}
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}, {
			name:       "grpc"
			port:       50051
			targetPort: "thanos-grpc"
		}]
		selector: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/component": "server"
		}
	}
}, {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "thanos-sidecar-telemetry"
		annotations: "prometheus.io/scrape": "true"
		labels: {
			"app.kubernetes.io/component": "sidecar"
			"app.kubernetes.io/instance":  "thanos"
			"app.kubernetes.io/name":      "thanos"
			"app.kubernetes.io/version":   "0.18.0"
		}
	}
	spec: {
		ports: [{
			name:       "http-metrics"
			port:       80
			targetPort: "thanos-http"
		}]
		selector: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/component": "server"
		}
	}
}]
