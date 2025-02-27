package jellyfin

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
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}, {
			name:       "https"
			port:       443
			targetPort: "https"
		}, {
			name:       "upnp"
			port:       1900
			targetPort: "upnp"
		}, {
			name:       "discovery"
			port:       7359
			targetPort: "discovery"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
