package loki

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
	metadata: name: "\(#Name)-memberlist"
	spec: {
		ports: [{
			name:       "tcp"
			port:       7946
			targetPort: "http-memberlist"
		}]
		selector: {
			"app.kubernetes.io/name":    "loki"
			"app.kubernetes.io/part-of": "memberlist"
		}
		clusterIP: v1.#ClusterIPNone
	}
}]
