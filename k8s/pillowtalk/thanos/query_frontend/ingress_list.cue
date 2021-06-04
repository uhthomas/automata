package query_frontend

import networkingv1 "k8s.io/api/networking/v1"

ingressList: networkingv1.#IngressList & {
	apiVersion: "networking.k8s.io/v1"
	kind:       "IngressList"
	items: [...{
		apiVersion: "networking.k8s.io/v1"
		kind:       "Ingress"
	}]
}

ingressList: items: [{
	spec: {
		ingressClassName: "nginx"
		rules: [{
			host: "thanos.pillowtalk.starjunk.net"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "query-frontend"
					port: name: "http"
				}
			}]
		}]
	}
}]
