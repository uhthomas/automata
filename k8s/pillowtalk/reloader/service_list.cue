package reloader

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
	spec: {
		clusterIP: "None"
		ports: [{
			name:       "http"
			port:       9090
			targetPort: "http"
		}]
		selector: {
			"app.kubernetes.io/name":      "reloader"
			"app.kubernetes.io/instance":  "reloader"
			"app.kubernetes.io/component": "reloader"
		}
	}
}]
