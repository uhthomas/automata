package depot

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
	metadata: annotations: "external-dns.alpha.kubernetes.io/hostname": "depot-magiclove.hipparcos.net"
	spec: {
		ports: [{
			name:       "smb"
			port:       445
			targetPort: "smb"
		}]
		selector: "app.kubernetes.io/name": #Name
		type:                  v1.#ServiceTypeLoadBalancer
		externalTrafficPolicy: v1.#ServiceExternalTrafficPolicyLocal
	}
}]
