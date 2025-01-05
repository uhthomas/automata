package onepassword_connect

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
			name:       "connect-api"
			port:       8080
			targetPort: "api-http"
		}, {
			name:       "connect-sync"
			port:       8081
			targetPort: "sync-http"
		}]
		selector: "app.kubernetes.io/name": #Name
	}
}]
