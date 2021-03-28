package server

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
		name: "server"
		labels: {
			"app.kubernetes.io/name":      "prometheus"
			"app.kubernetes.io/instance":  "prometheus"
			"app.kubernetes.io/version":   "2.25.1"
			"app.kubernetes.io/component": "server"
		}
	}
}]
