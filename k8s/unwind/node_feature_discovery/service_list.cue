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
			port:     8080
			protocol: "TCP"
		}]
		selector: app: "nfd-master"
	}
}]
