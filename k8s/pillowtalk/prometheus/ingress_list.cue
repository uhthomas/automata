package prometheus

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
	// metadata: annotations: {
	//  "nginx.ingress.kubernetes.io/auth-url":    "http://oauth2-proxy.oauth2-proxy.svc.cluster.local/oauth2/auth"
	//  "nginx.ingress.kubernetes.io/auth-signin": "https://oauth2-proxy.mahalo.starjunk.net/oauth2/start?rd=$scheme://$host$request_uri"
	// }
	spec: {
		ingressClassName: "nginx"
		rules: [{
			host: "prometheus.pillowtalk.starjunk.net"
			http: paths: [{
				pathType: "ImplementationSpecific"
				backend: service: {
					name: "prometheus-operated"
					port: name: "web"
				}
			}]
		}]
	}
}]
