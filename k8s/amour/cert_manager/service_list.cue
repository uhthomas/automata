package cert_manager

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
	metadata: labels: {
		app:                           "cert-manager"
		"app.kubernetes.io/name":      "cert-manager"
		"app.kubernetes.io/instance":  "cert-manager"
		"app.kubernetes.io/component": "controller"
	}
	spec: {
		type: "ClusterIP"
		ports: [{
			name: "tcp-prometheus-servicemonitor"
			port: 9402
		}]
		selector: {
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "controller"
		}
	}
}, {
	metadata: {
		name: "cert-manager-webhook"
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "webhook"
		}
	}
	spec: {
		type: "ClusterIP"
		ports: [{
			name:       "https"
			port:       443
			targetPort: "https"
		}]
		selector: {
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "webhook"
		}
	}
}]
