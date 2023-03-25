package rook_ceph

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
		name: "rook-ceph-mgr-dashboard-tailscale"
		annotations: "tailscale.com/hostname": "\(#Name)-unwind"
	}
	spec: {
		ports: [{
			name:       "https"
			port:       443
			targetPort: "dashboard"
		}]
		selector: {
			app:          "rook-ceph-mgr"
			rook_cluster: "rook-ceph"
		}
		type:              v1.#ServiceTypeLoadBalancer
		loadBalancerClass: "tailscale"
	}
}]
