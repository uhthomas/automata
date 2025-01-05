package volsync_system

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
	metadata: name: "\(#Name)-metrics"
	spec: {
		ports: [{
			name:       "https"
			port:       443
			targetPort: "https"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
