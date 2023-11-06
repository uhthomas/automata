package hubble_ui

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
	metadata: name: "hubble-ui"
	spec: {
		ingressClassName: "tailscale"
		defaultBackend: service: {
			name: #Name
			port: name: "http"
		}
		tls: [{hosts: ["hubble-amour-k8s"]}]
	}
}]
