package rook_ceph

import "k8s.io/api/core/v1"

serviceList: v1.#ServiceList & {
	apiVersion: "v1"
	kind:       "ServiceList"
	items: [...{
		apiVersion: "v1"
		kind:       "Service"
	}]
}

serviceList: items: [{
	metadata: name: "rook-ceph-mgr-dashboard-tailscale"
	spec: {
		ports: [{
			name:       "https"
			port:       443
			protocol:   v1.#ProtocolTCP
			targetPort: "dashboard"
		}]
		selector: {
			app:          "rook-ceph-mgr"
			rook_cluster: "rook-ceph"
		}
		sessionAffinity:   v1.#ServiceAffinityNone
		type:              v1.#ServiceTypeLoadBalancer
		loadBalancerClass: "tailscale"
	}
}]
