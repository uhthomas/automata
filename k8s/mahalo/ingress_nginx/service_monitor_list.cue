package ingress_nginx

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
	metadata: {
		name: "ingress-nginx-controller"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
	}
	spec: {
		endpoints: [{
			port:        "metrics"
			honorLabels: true
		}]
		selector: matchLabels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
	}
}]
