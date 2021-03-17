package cert_manager

import "k8s.io/api/core/v1"

service: [...v1.#Service]

service: [{
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "cert-manager"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
	}, spec: {
		ports: [{
			port:       9402
			protocol:   "TCP"
			targetPort: 9402
		}]
		selector: {
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
		type: v1.#ServiceTypeClusterIP
	}
}, {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "cert-manager-webhook"
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/component": "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "webhook"
		}
	}, spec: {
		ports: [{
			name:       "https"
			port:       443
			targetPort: 10250
		}]
		selector: {
			"app.kubernetes.io/component": "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "webhook"
		}
		type: v1.#ServiceTypeClusterIP
	}
}]
