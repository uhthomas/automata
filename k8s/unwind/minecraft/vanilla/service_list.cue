package vanilla

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
	metadata: annotations: "tailscale.com/hostname": "\(#Name)-unwind-k8s"
	spec: {
		ports: [{
			name:       "minecraft"
			port:       25565
			targetPort: "minecraft"
		}]
		selector: "app.kubernetes.io/name": #Name
		type:              v1.#ServiceTypeLoadBalancer
		loadBalancerClass: "tailscale"
	}
}]
