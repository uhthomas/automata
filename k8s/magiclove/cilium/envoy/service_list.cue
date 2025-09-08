package envoy

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
		name: #Name
		annotations: {
			"prometheus.io/scrape": "true"
			"prometheus.io/port":   "9964"
		}
		labels: {
			"k8s-app":                   "cilium-envoy"
			"app.kubernetes.io/name":    "cilium-envoy"
			"app.kubernetes.io/part-of": "cilium"
			"io.cilium/app":             "proxy"
		}
	}
	spec: {
		ports: [{
			name:       "envoy-metrics"
			port:       9964
			targetPort: "envoy-metrics"
		}]
		selector: "k8s-app": "cilium-envoy"
		clusterIP: "None"
	}
}]
