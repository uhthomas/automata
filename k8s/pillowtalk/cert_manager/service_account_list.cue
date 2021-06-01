package cert_manager

import "k8s.io/api/core/v1"

serviceAccountList: v1.#ServiceAccountList & {
	apiVersion: "v1"
	kind:       "ServiceAccountList"
	items: [...{
		apiVersion: "v1"
		kind:       "ServiceAccount"
	}]
}

serviceAccountList: items: [{
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
	metadata: {
		name: "cert-manager-webhook"
		labels: {
			app:                           "webhook"
			"app.kubernetes.io/name":      "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/version":   "1.2.0"
			"app.kubernetes.io/component": "webhook"
		}
	}
}]
