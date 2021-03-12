package cert_manager

import "k8s.io/api/core/v1"

service_account: [...v1.#ServiceAccount]

service_account: [{
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name: "cert-manager-cainjector"
		labels: {
			app:                           "cainjector"
			"app.kubernetes.io/name":      "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/version":   "1.2.0"
			"app.kubernetes.io/component": "cainjector"
		}
	}
}, {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name: "cert-manager"
		labels: {
			app:                           "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/version":   "1.2.0"
			"app.kubernetes.io/component": "controller"
		}
	}
}, {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name: "webhook"
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/version":   "1.2.0"
			"app.kubernetes.io/component": "webhook"
		}
	}
}]
