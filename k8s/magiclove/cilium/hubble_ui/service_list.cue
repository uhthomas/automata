package hubble_ui

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
		name: "hubble-ui"
		labels: {
			"k8s-app":                   "hubble-ui"
			"app.kubernetes.io/name":    "hubble-ui"
			"app.kubernetes.io/part-of": "cilium"
		}
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: "k8s-app": "hubble-ui"
	}
}]
