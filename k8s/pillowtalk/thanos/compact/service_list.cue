package compact

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
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		clusterIP: v1.#ClusterIPNone
		selector: {
			"app.kubernetes.io/name":      "thanos"
			"app.kubernetes.io/instance":  "thanos"
			"app.kubernetes.io/component": "compact"
		}
	}
}]
