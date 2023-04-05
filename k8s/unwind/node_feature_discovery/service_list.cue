package node_feature_discovery

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
	metadata: name: "nfd-master"
	spec: {
		ports: [{
			name:       "http"
			port:       8080
			targetPort: "http"
		}]
		selector: {
			"app.kubernetes.io/name":      #Name
			"app.kubernetes.io/component": "master"
		}
	}
}]
