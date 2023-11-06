package rook_ceph

import networkingv1 "k8s.io/api/networking/v1"

#IngressList: networkingv1.#IngressList & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "IngressList"
	items: [...{
		apiVersion: "networking.k8s.io/v1"
		kind:       "Ingress"
	}]
}

#IngressList: items: [{
	spec: {
		ingressClassName: "tailscale"
		defaultBackend: service: {
			name: "rook-ceph-mgr-dashboard-tailscale"
			port: name: "https"
		}
		tls: [{hosts: ["rook-ceph-amour-k8s"]}]
	}
}]
