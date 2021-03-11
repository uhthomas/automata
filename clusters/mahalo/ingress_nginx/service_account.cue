package ingress_nginx

import corev1 "k8s.io/api/core/v1"

service_account: [...corev1.#ServiceAccount]

service_account: [{
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name: "ingress-nginx"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
			"app.kubernetes.io/component": "controller"
		}
	}
}, {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name: "ingress-nginx-admission"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
			"app.kubernetes.io/component": "admission-webhook"
		}
	}
}]
