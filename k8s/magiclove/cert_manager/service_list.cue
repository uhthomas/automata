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
		ports: [{
			name: "http-metrics"
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
		ports: [{
			name:       "https"
			port:       443
			targetPort: "https"
		}, {
			name:       "http-metrics"
			port:       9402
			targetPort: "http-metrics"
		}]
		selector: {
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "webhook"
		}
	}
}, {
	metadata: {
		name: "cert-manager-cainjector"
		labels: {
			app:                           "cainjector"
			"app.kubernetes.io/name":      "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cainjector"
		}
	}
	spec: {
		ports: [{
			name: "http-metrics"
			port: 9402
		}]
		selector: {
			"app.kubernetes.io/name":      "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/component": "cainjector"
		}
	}
}]
