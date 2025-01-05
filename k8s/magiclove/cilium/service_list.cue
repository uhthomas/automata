package cilium

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
		name: "hubble-peer"
		labels: {
			"k8s-app":                   "cilium"
			"app.kubernetes.io/part-of": "cilium"
			"app.kubernetes.io/name":    "hubble-peer"
		}
	}
	spec: {
		ports: [{
			name:       "peer-service"
			port:       443
			targetPort: 4244
		}]
		selector: "k8s-app": "cilium"
		internalTrafficPolicy: v1.#ServiceInternalTrafficPolicyLocal
	}
}]
