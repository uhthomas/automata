package backup

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
	metadata: name: "smb"
	spec: {
		ports: [{
			name:       "smb"
			port:       445
			targetPort: "smb"
		}]
		selector: "app.kubernetes.io/name": "smb"
		type: v1.#ServiceTypeLoadBalancer
	}
}]
