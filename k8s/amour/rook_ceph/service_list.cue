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
	metadata: name: "rook-ceph-mgr-dashboard-tailscale"
	spec: {
		ports: [{
			name:       "https"
			port:       443
			targetPort: "dashboard"
		}]
		selector: {
			app:          "rook-ceph-mgr"
			mgr_role:     "active"
			rook_cluster: #Namespace
		}
	}
}]
