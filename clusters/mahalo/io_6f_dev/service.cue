package io_6f_dev

import "k8s.io/api/core/v1"

serviceList: v1.#ServiceList & {
	apiVersion: "v1"
	kind:       "List"
}

serviceList: items: [{
	apiVersion: "v1"
	kind:       "Service"
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: app: "io-6f-dev"
	}
}]
