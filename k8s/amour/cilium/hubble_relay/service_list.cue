package hubble_relay

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
	metadata: {
		name: "hubble-relay"
		labels: {
			"k8s-app":                   "hubble-relay"
			"app.kubernetes.io/name":    "hubble-relay"
			"app.kubernetes.io/part-of": "cilium"
		}
	}
	spec: {
		ports: [{
			name:       "grpc"
			port:       443
			targetPort: "grpc"
		}]
		selector: "k8s-app": "hubble-relay"
	}
}]
