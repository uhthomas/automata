package ingress_nginx

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
	metadata: {
		name: "ingress-nginx-controller-admission"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
	}
	spec: {
		type: v1.#ServiceTypeClusterIP
		ports: [{
			name:       "https-webhook"
			port:       443
			targetPort: "webhook"
		}]
		selector: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
	}
}, {
	metadata: {
		name: "ingress-nginx-controller"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			protocol:   v1.#ProtocolTCP
			targetPort: "http"
		}, {
			name:       "https"
			port:       443
			protocol:   v1.#ProtocolTCP
			targetPort: "https"
		}, {
			name:       "metrics"
			port:       10254
			protocol:   v1.#ProtocolTCP
			targetPort: "metrics"
		}]
		selector: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/component": "controller"
		}
	}
}]
